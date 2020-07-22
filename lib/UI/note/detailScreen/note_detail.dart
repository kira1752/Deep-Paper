import 'package:deep_paper/UI/note/widgets/bottom_menu.dart';
import 'package:deep_paper/UI/note/widgets/date_character_counts.dart';
import 'package:deep_paper/UI/note/widgets/deep_dialog.dart';
import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/UI/widgets/deep_keep_alive.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/business_logic/note/note_detail_lifecycle.dart';
import 'package:deep_paper/business_logic/note/note_detail_normal_save.dart';
import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/business_logic/note/text_field_logic.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  final int folderID;
  final String folderName;

  NoteDetail(
      {@required this.folderID,
      @required this.folderName,
      @required this.note});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> with WidgetsBindingObserver {
  Future<String> _date;
  TextEditingController _detailController;
  FocusNode _detailFocus;
  DeepPaperDatabase _database;
  UndoRedoProvider _undoRedoProvider;
  NoteDetailProvider _detailProvider;

  @override
  void initState() {
    super.initState();

    // Watch Deep Paper app lifecycle when user creating new note
    WidgetsBinding.instance.addObserver(this);

    _database = Provider.of<DeepPaperDatabase>(context, listen: false);
    _undoRedoProvider = Provider.of<UndoRedoProvider>(context, listen: false);
    _detailProvider = Provider.of<NoteDetailProvider>(context, listen: false);
    _detailProvider.setNote = widget.note;

    String detail =
        _detailProvider.getNote.isNull ? "" : _detailProvider.getNote.detail;

    _undoRedoProvider.initialDetail = detail;
    _detailProvider.setDetail = detail;
    _detailProvider.setTempDetail = detail;
    _detailController = TextEditingController(text: detail);
    _detailFocus = FocusNode();

    if (_detailProvider.getNote.isNull) {
      _date = TextFieldLogic.loadDateAsync(null);

      Future.delayed(Duration(milliseconds: 300), () {
        _detailFocus.requestFocus();

        _undoRedoProvider.tempInitialCursorPosition =
            _detailController.selection.extentOffset;
      });
    } else {
      _date = TextFieldLogic.loadDateAsync(_detailProvider.getNote.modified);
    }

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
    // Release the resource used by these observer and controller when user exit Note Creation UI
    WidgetsBinding.instance.removeObserver(this);
    _detailController.dispose();
    _detailFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    NoteDetailLifecycle.check(
        context: context,
        state: state,
        detailProvider: _detailProvider,
        folderID: widget.folderID,
        folderName: widget.folderName);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: Color(0xff202020),
        ),
        primaryColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        bottomAppBarColor: Theme.of(context).bottomAppBarColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: WillPopScope(
          onWillPop: () async {
            NoteDetailNormalSave.run(
                context: context,
                noteID: _detailProvider.getNoteID,
                note: _detailProvider.getNote,
                detailProvider: _detailProvider,
                folderID: widget.folderID,
                folderName: widget.folderName,
                isDeleted: _detailProvider.getIsDeleted,
                isCopy: _detailProvider.getIsCopy);

            return true;
          },
          child: Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).accentColor.withOpacity(0.80),
                  ),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                ),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(56),
                    child: DateCharacterCounts(
                        date: _date, detail: _detailProvider.getDetail))),
            bottomNavigationBar: BottomMenu(
              detailController: _detailController,
              onDelete: () {
                if (!_detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  _detailProvider.setIsDeleted = true;

                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                    DeepToast.showToast(description: "Note moved to Trash Bin");
                  });
                } else if (_detailProvider.getNoteID.isNull &&
                    _detailProvider.getNote.isNull) {
                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                    DeepToast.showToast(description: "Empty note deleted");
                  });
                } else {
                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                  });
                }
              },
              onCopy: () {
                if (_detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  Navigator.of(context).pop();
                  DeepToast.showToast(description: "Cannot copy empty note");
                } else {
                  _detailProvider.setIsCopy = true;

                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                    DeepToast.showToast(
                        description: "Note copied successfully");
                  });
                }
              },
              noteInfo: () async {
                final created = await _database.noteDao
                    .getCreatedDate(_detailProvider.getNoteID);

                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 400), () {
                  DeepDialog.openNoteInfo(
                      context: context,
                      folderName: widget.folderName,
                      modified: _detailProvider.getNote.isNull
                          ? DateTime.now()
                          : (_detailProvider.getNote.detail !=
                          _detailProvider.getDetail
                          ? DateTime.now()
                          : _detailProvider.getNote.modified),
                      created: _detailProvider.getNoteID.isNull
                          ? (_detailProvider.getNote.isNull
                          ? DateTime.now()
                          : _detailProvider.getNote.created)
                          : created);
                });
              },
            ),
            body: ScrollConfiguration(
              behavior: DeepScrollBehavior(),
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
                        padding: EdgeInsets.fromLTRB(18, 0, 16, 16),
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
        builder: (context, direction, child) {
          return TextField(
            controller: widget.detailController,
            focusNode: widget.detailFocus,
            showCursor: true,
            textDirection: direction,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white.withOpacity(0.80),
                fontWeight: FontWeight.normal,
                fontSize: SizeHelper.getDetail),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onTap: () {
              _undoRedoProvider.tempInitialCursorPosition =
                  widget.detailController.selection.extentOffset;
            },
            onChanged: (value) => TextFieldLogic.detail(
                value: value,
                detailProvider: _detailProvider,
                undoRedoProvider: _undoRedoProvider,
                controller: widget.detailController),
            decoration: InputDecoration.collapsed(
                hintText: 'Write your note here...',
                hintStyle: TextStyle(fontWeight: FontWeight.w500)),
          );
        });
  }
}
