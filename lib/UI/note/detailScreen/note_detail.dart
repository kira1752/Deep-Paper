import 'package:deep_paper/UI/note/widgets/bottom_menu.dart';
import 'package:deep_paper/UI/note/widgets/deep_dialog.dart';
import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/UI/widgets/deep_keep_alive.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/bussiness_logic/note/note_creation.dart';
import 'package:deep_paper/bussiness_logic/note/note_detail_normal_save.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/bussiness_logic/note/text_field_logic.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
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
  bool _isDeleted;
  bool _isCopy;
  String _date;
  Note _note;
  int _noteID;
  String _detail;
  TextEditingController _detailController;
  FocusNode _detailFocus;

  @override
  void initState() {
    super.initState();

    // Watch Deep Paper app lifecycle when user creating new note
    WidgetsBinding.instance.addObserver(this);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);
    final noteDetailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    _note = widget.note;
    _detail = _note.isNull ? "" : _note.detail;

    undoRedoProvider.initialDetail = _detail;
    noteDetailProvider.setDetail = _detail;

    _isDeleted = _note.isNull ? false : _note.isDeleted;
    _isCopy = false;
    _detailController = TextEditingController(text: _detail);
    _detailFocus = FocusNode();

    if (_note.isNull) {
      _date = DateFormat.jm('en_US').format(DateTime.now());

      Future.delayed(Duration(milliseconds: 300), () {
        final undoRedoProvider =
            Provider.of<UndoRedoProvider>(context, listen: false);

        _detailFocus.requestFocus();

        undoRedoProvider.tempInitialCursorPosition =
            _detailController.selection.extentOffset;
      });
    } else {
      final DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final DateTime noteDate = DateTime(
          _note.modified.year, _note.modified.month, _note.modified.day);

      _date = now.difference(noteDate).inDays == 0
          ? DateFormat.jm("en_US").format(_note.modified)
          : (now.difference(noteDate).inDays == 1
          ? "Yesterday, ${DateFormat.jm("en_US").format(_note.modified)}"
              : (now.difference(noteDate).inDays > 1 &&
          now.year - _note.modified.year == 0
          ? DateFormat.MMMd("en_US").add_jm().format(_note.modified)
          : DateFormat.yMMMd("en_US").add_jm().format(_note.modified)));
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
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    if (state == AppLifecycleState.inactive) {
      if (_noteID.isNull && _note.isNull) {
        // Create note data when user tapping home button
        // and there is no Note data exist in database
        _detail = detailProvider.getDetail;
        _noteID = await NoteCreation.create(
          context: context,
          detail: detailProvider.getDetail,
          detailDirection:
              Bidi.detectRtlDirectionality(detailProvider.getDetail)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          folderID: widget.folderID,
          folderName: widget.folderName,
          folderNameDirection: Bidi.detectRtlDirectionality(widget.folderName)
              ? TextDirection.rtl
              : TextDirection.ltr,
          isCopy: _isCopy,
          isDeleted: _isDeleted,
        );
      } else {
        if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
          NoteCreation.deleteEmptyNote(
              context: context, noteID: _note.isNull ? _noteID : _note.id);
          _noteID = null;
          _note = null;
        } else if (_note.isNotNull) {
          // Update note with latest date if there is any changes in detail
          // then user exit the app not using the usual pop
          // like using home button, chat notification, etc
          if (_detail != detailProvider.getDetail) {
            _detail = detailProvider.getDetail;

            NoteCreation.update(
                context: context,
                noteID: _note.id,
                detail: detailProvider.getDetail,
                folderID: widget.folderID,
                folderName: widget.folderName,
                modified: DateTime.now(),
                isDeleted: _isDeleted,
                isCopy: _isCopy);
          }
        } else {
          // Same as above but this run only when there is no note data provided
          // like when creating new note because of user pressing home button, etc
          // then user continue editing the note,
          // then pressing home button again, etc
          if (_detail != detailProvider.getDetail) {
            _detail = detailProvider.getDetail;

            NoteCreation.update(
                context: context,
                noteID: _noteID,
                detail: detailProvider.getDetail,
                folderID: widget.folderID,
                folderName: widget.folderName,
                modified: DateTime.now(),
                isDeleted: _isDeleted,
                isCopy: _isCopy);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

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
                noteID: _noteID,
                note: _note,
                detailProvider: detailProvider,
                detail: _detail,
                folderID: widget.folderID,
                folderName: widget.folderName,
                isDeleted: _isDeleted,
                isCopy: _isCopy);

            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme
                      .of(context)
                      .accentColor
                      .withOpacity(0.87),
                ),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            ),
            bottomNavigationBar: BottomMenu(
              date: _date,
              detailController: _detailController,
              onDelete: () {
                if (!detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  _isDeleted = true;

                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                    DeepToast.showToast(description: "Note moved to Trash Bin");
                  });
                } else if (_noteID.isNull && _note.isNull) {
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
                if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  Navigator.of(context).pop();
                  DeepToast.showToast(description: "Cannot copy empty note");
                } else {
                  _isCopy = true;

                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 400), () {
                    Navigator.maybePop(context);
                    DeepToast.showToast(
                        description: "Note copied successfully");
                  });
                }
              },
              noteInfo: () async {
                final database =
                Provider.of<DeepPaperDatabase>(context, listen: false);

                final created = await database.noteDao.getCreatedDate(_noteID);

                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 400), () {
                  DeepDialog.openNoteInfo(
                      context: context,
                      folderName: widget.folderName,
                      modified: _note.isNull
                          ? DateTime.now()
                          : (_note.detail != detailProvider.getDetail
                          ? DateTime.now()
                          : _note.modified),
                      created: _noteID.isNull
                          ? (_note.isNull ? DateTime.now() : _note.created)
                          : created);
                });
              },
            ),
            body: ScrollConfiguration(
              behavior: DeepScrollBehavior(),
              child: GestureDetector(
                onTap: () {
                  final undoRedoProvider =
                  Provider.of<UndoRedoProvider>(context, listen: false);
                  if (!_detailFocus.hasFocus) {
                    _detailFocus.requestFocus();
                  }
                  _detailController.selection =
                      TextSelection.fromPosition(TextPosition(
                        offset: undoRedoProvider.initialDetail.length,
                      ));

                  if (!undoRedoProvider.canUndo()) {
                    undoRedoProvider.tempInitialCursorPosition =
                        undoRedoProvider.initialDetail.length;
                  }
                },
                child: ListView(
                  children: <Widget>[
                    DeepKeepAlive(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(18, 24, 16, 16),
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
