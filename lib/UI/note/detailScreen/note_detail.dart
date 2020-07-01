import 'package:deep_paper/UI/note/widgets/bottom_menu.dart';
import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/UI/widgets/deep_keep_alive.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/bussiness_logic/note/note_creation.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/bussiness_logic/note/text_field_logic.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

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
  TextEditingController _detailController;
  FocusNode _detailFocus;

  @override
  void initState() {
    super.initState();

    // Watch Deep Paper app lifecycle when user creating new note
    WidgetsBinding.instance.addObserver(this);

    _note = widget.note;
    String _detail = _note.isNull ? "" : _note.detail;

    Provider.of<UndoRedoProvider>(context, listen: false).setInitialDetail =
        _detail;
    Provider.of<NoteDetailProvider>(context, listen: false).setDetail = _detail;

    _isDeleted = _note.isNull ? false : _note.isDeleted;
    _isCopy = false;
    _detailController = TextEditingController(text: _detail);
    _detailFocus = FocusNode();

    if (_note.isNull) {
      _date = DateFormat.jm('en_US').format(DateTime.now());

      Future.delayed(
          Duration(milliseconds: 300), () => _detailFocus.requestFocus());
    } else {
      final DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final DateTime noteDate =
          DateTime(_note.date.year, _note.date.month, _note.date.day);

      _date = now.difference(noteDate).inDays == 0
          ? DateFormat.jm("en_US").format(_note.date)
          : (now.difference(noteDate).inDays == 1
              ? "Yesterday, ${DateFormat.jm("en_US").format(_note.date)}"
              : (now.difference(noteDate).inDays > 1 &&
                      now.year - _note.date.year == 0
                  ? DateFormat.MMMd("en_US").add_jm().format(_note.date)
                  : DateFormat.yMMMd("en_US").add_jm().format(_note.date)));
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
          if (_note.detail != detailProvider.getDetail ||
              _note.isDeleted != _isDeleted) {
            debugPrintSynchronously("update note run");
            if (!detailProvider.getDetail.isNullEmptyOrWhitespace) {
              NoteCreation.update(
                  context: context,
                  noteID: _note.id,
                  detail: detailProvider.getDetail,
                  folderID: widget.folderID,
                  folderName: widget.folderName,
                  isDeleted: _isDeleted,
                  isCopy: _isCopy);
            }
          }
        } else {
          debugPrintSynchronously("update note run");
          NoteCreation.update(
              context: context,
              noteID: _noteID,
              detail: detailProvider.getDetail,
              folderID: widget.folderID,
              folderName: widget.folderName,
              isDeleted: _isDeleted,
              isCopy: _isCopy);
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
            if (_noteID.isNotNull || _note.isNotNull) {
              if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
                NoteCreation.deleteEmptyNote(
                    context: context,
                    noteID: _note.isNull ? _noteID : _note.id);

                DeepToast.showToast(description: "Empty note deleted");
              } else if (_note.isNotNull) {
                if (_note.detail != detailProvider.getDetail ||
                    _note.isDeleted != _isDeleted) {
                  debugPrintSynchronously("update note run");
                  if (!detailProvider.getDetail.isNullEmptyOrWhitespace) {
                    NoteCreation.update(
                        context: context,
                        noteID: _note.id,
                        detail: detailProvider.getDetail,
                        folderID: widget.folderID,
                        folderName: widget.folderName,
                        isDeleted: _isDeleted,
                        isCopy: _isCopy);
                  }
                } else if (_isCopy) {
                  NoteCreation.copy(
                      context: context,
                      detail: detailProvider.getDetail,
                      detailDirection:
                          Bidi.detectRtlDirectionality(detailProvider.getDetail)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      folderID: widget.folderID,
                      folderName: widget.folderName,
                      folderNameDirection:
                          Bidi.detectRtlDirectionality(widget.folderName)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                     );
                }
              } else {
                debugPrintSynchronously("update note run");
                NoteCreation.update(
                    context: context,
                    noteID: _noteID,
                    detail: detailProvider.getDetail,
                    folderID: widget.folderID,
                    folderName: widget.folderName,
                    isDeleted: _isDeleted,
                    isCopy: _isCopy);
              }
            } else {
              NoteCreation.create(
                  context: context,
                  detail: detailProvider.getDetail,
                  detailDirection:
                      Bidi.detectRtlDirectionality(detailProvider.getDetail)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  folderID: widget.folderID,
                  folderName: widget.folderName,
                  folderNameDirection:
                      Bidi.detectRtlDirectionality(widget.folderName)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                  isDeleted: _isDeleted,
                  isCopy: _isCopy);
            }

            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
              elevation: 0.0,
              centerTitle: true,
            ),
            bottomNavigationBar: BottomMenu(
              date: _date,
              newNote: false,
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
            ),
            body: ScrollConfiguration(
              behavior: DeepScrollBehavior(),
              child: GestureDetector(
                onTap: () {
                  if (!_detailFocus.hasFocus) {
                    _detailFocus.requestFocus();
                  }
                },
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    DeepKeepAlive(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(18, 24, 16, 16),
                        child: _detailField(),
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

  Widget _detailField() {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    detailProvider.checkDetailDirection = detailProvider.getDetail;

    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
            provider.getDetailDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, child) {
          return TextField(
            controller: _detailController,
            focusNode: _detailFocus,
            showCursor: true,
            textDirection: direction,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white70, fontSize: SizeHelper.getDescription),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) => TextFieldLogic.detail(
                value: value,
                detailProvider: detailProvider,
                undoRedoProvider: undoRedoProvider),
            decoration: InputDecoration.collapsed(
              hintText: 'Write your note here...',
            ),
          );
        });
  }
}
