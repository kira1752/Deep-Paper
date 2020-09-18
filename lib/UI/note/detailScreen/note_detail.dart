import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/note_detail_lifecycle.dart' as lifecycle;
import '../../../business_logic/note/note_detail_normal_save.dart' as save;
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_redo_provider.dart';
import '../../../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../../../data/deep.dart';
import '../../../icons/my_icon.dart';
import '../../../resource/string_resource.dart';
import '../../../utility/extension.dart';
import '../../../utility/size_helper.dart';
import '../../widgets/deep_keep_alive.dart';
import '../../widgets/deep_scroll_behavior.dart';
import '../../widgets/deep_toast.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/date_character_counts.dart';
import '../widgets/dialog/note_dialog.dart' as note_dialog;

class NoteDetail extends StatefulWidget {
  final int folderID;
  final String folderName;
  final Note note;

  const NoteDetail(
      {@required this.folderID,
      @required this.folderName,
      @required this.note});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

// ignore: prefer_mixin
class _NoteDetailState extends State<NoteDetail> with WidgetsBindingObserver {
  Future<String> _date;
  TextEditingController _detailController;
  FocusNode _detailFocus;
  DeepPaperDatabase _database;
  UndoRedoProvider _undoRedoProvider;
  NoteDetailProvider _detailProvider;
  Timer _debounce;

  void _whenUserTyping() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final _value = _undoRedoProvider.currentTyped.value;
      if (!_value.isNullEmptyOrWhitespace &&
          _undoRedoProvider.getUndoLastValue() != _value &&
          _undoRedoProvider.getRedoLastValue() != _value) {
        _undoRedoProvider.addUndo();
        _undoRedoProvider.currentTyped.value = null;
        _undoRedoProvider.currentCursorPosition = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Watch Deep Paper app lifecycle when user creating new note
    WidgetsBinding.instance.addObserver(this);

    _database = Provider.of<DeepPaperDatabase>(context, listen: false);
    _undoRedoProvider = Provider.of<UndoRedoProvider>(context, listen: false);
    _detailProvider = Provider.of<NoteDetailProvider>(context, listen: false);
    _detailProvider.setNote = widget.note;

    final detail = (_detailProvider.getNote?.detail) ?? '';

    _undoRedoProvider.initialDetail = detail;
    _detailProvider.setDetail = detail;
    _detailProvider.setTempDetail = detail;
    _detailController = TextEditingController(text: detail);
    _detailFocus = FocusNode();

    if (_detailProvider.getNote.isNull) {
      _date = text_field_logic.loadDateAsync(null);

      Future.delayed(const Duration(milliseconds: 400), () {
        _detailFocus.requestFocus();

        _undoRedoProvider.tempInitialCursorPosition =
            _detailController.selection.baseOffset;
      });
    } else {
      _date = text_field_logic.loadDateAsync(_detailProvider.getNote.modified);
    }

    // Save user typing state to Undo queue when user stop typing for
    // 1000 milliseconds
    _undoRedoProvider.currentTyped.addListener(_whenUserTyping);

    KeyboardVisibility.onChange.listen((visible) {
      if (visible == false) {
        if (_detailFocus.hasFocus) {
          _detailFocus.unfocus();
        }
      }
    });
  }

  @override
  void dispose() {
    // Release the resource used by these observer and controller
    // when user exit Note Creation UI
    WidgetsBinding.instance.removeObserver(this);

    _debounce?.cancel();
    _undoRedoProvider.currentTyped.dispose();
    _detailController.dispose();
    _detailFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    lifecycle.check(
        database: _database,
        state: state,
        detailProvider: _detailProvider,
        folderID: widget.folderID ?? 0,
        folderName: widget.folderName ?? StringResource.mainFolder);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          modalBackgroundColor: Color(0xff202020),
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          save.run(
              database: _database,
              noteID: _detailProvider.getTempNoteID,
              note: _detailProvider.getNote,
              detailProvider: _detailProvider,
              folderID: widget.folderID ?? 0,
              folderName: widget.folderName ?? StringResource.mainFolder,
              isDeleted: _detailProvider.getIsDeleted,
              isCopy: _detailProvider.getIsCopy);

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  MyIcon.arrow_left,
                  color: Theme.of(context).accentColor.withOpacity(0.80),
                ),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: DateCharacterCounts(
                      date: _date, detail: _detailProvider.getDetail))),
          bottomNavigationBar: BottomMenu(
            detailController: _detailController,
            onDelete: () {
              if (!_detailProvider.getDetail.isNullEmptyOrWhitespace) {
                _detailProvider.setIsDeleted = true;

                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.maybePop(context);
                  DeepToast.showToast(description: 'Note moved to Trash Bin');
                });
              } else if (_detailProvider.getTempNoteID.isNull &&
                  _detailProvider.getNote.isNull) {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.maybePop(context);
                  DeepToast.showToast(description: 'Empty note deleted');
                });
              } else {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.maybePop(context);
                });
              }
            },
            onCopy: () {
              if (_detailProvider.getDetail.isNullEmptyOrWhitespace) {
                Navigator.pop(context);

                DeepToast.showToast(description: 'Cannot copy empty note');
              } else {
                _detailProvider.setIsCopy = true;

                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.maybePop(context);
                  DeepToast.showToast(description: 'Note copied successfully');
                });
              }
            },
            noteInfo: () async {
              final created = await _database.noteDao
                  .getCreatedDate(_detailProvider.getTempNoteID);

              Navigator.pop(context);

              Future.delayed(const Duration(milliseconds: 400), () {
                note_dialog.openNoteInfo(
                    context: context,
                    folderName: widget.folderName ?? StringResource.mainFolder,
                    modified: _detailProvider.getNote.isNull
                        ? DateTime.now()
                        : (_detailProvider.getNote.detail !=
                                _detailProvider.getDetail
                            ? DateTime.now()
                            : _detailProvider.getNote.modified),
                    created: _detailProvider.getTempNoteID.isNull
                        ? (_detailProvider.getNote.isNull
                            ? DateTime.now()
                            : _detailProvider.getNote.created)
                        : created);
              });
            },
          ),
          body: ScrollConfiguration(
            behavior: const DeepScrollBehavior(),
            child: GestureDetector(
              onTap: () {
                if (!_detailFocus.hasFocus) {
                  _detailFocus.requestFocus();
                }
                _detailController.selection =
                    TextSelection.fromPosition(TextPosition(
                      offset: _detailProvider.getDetail.length,
                    ));

                if (!_undoRedoProvider.canUndo()) {
                  _undoRedoProvider.tempInitialCursorPosition =
                      _detailProvider.getDetail.length;
                }
              },
              child: ListView(
                children: <Widget>[
                  DeepKeepAlive(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 16, 16),
                      child: DetailField(
                        detailController: _detailController,
                        detailFocus: _detailFocus,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailField extends StatefulWidget {
  final TextEditingController detailController;
  final FocusNode detailFocus;

  const DetailField(
      {@required this.detailController, @required this.detailFocus});

  @override
  _DetailFieldState createState() => _DetailFieldState();
}

class _DetailFieldState extends State<DetailField> {
  NoteDetailProvider _detailProvider;
  UndoRedoProvider _undoRedoProvider;

  @override
  void initState() {
    super.initState();
    _detailProvider = Provider.of<NoteDetailProvider>(context, listen: false);

    _undoRedoProvider = Provider.of<UndoRedoProvider>(context, listen: false);

    _detailProvider.checkDetailDirection = _detailProvider.getDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
        provider.getDetailDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, _) =>
            TextField(
              controller: widget.detailController,
              focusNode: widget.detailFocus,
              showCursor: true,
              textDirection: direction,
              strutStyle: const StrutStyle(leading: 0.7),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(
                  color: Colors.white.withOpacity(.80),
                  fontWeight: FontWeight.normal,
                  fontSize: SizeHelper.getDetail),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onTap: () {
                _undoRedoProvider.tempInitialCursorPosition =
                    widget.detailController.selection.extentOffset;
              },
              onChanged: (value) =>
                  text_field_logic.detail(
                      value: value,
                      detailProvider: _detailProvider,
                      undoRedoProvider: _undoRedoProvider,
                      controller: widget.detailController),
              decoration: const InputDecoration.collapsed(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(fontWeight: FontWeight.w500)),
            ));
  }
}
