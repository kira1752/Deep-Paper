import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteDetailUpdate extends StatefulWidget {
  final Note note;

  NoteDetailUpdate(this.note);

  @override
  _NoteDetailUpdateState createState() => _NoteDetailUpdateState();
}

class _NoteDetailUpdateState extends State<NoteDetailUpdate> {
  bool _isDeleted;
  String _date;
  int _count = 0;
  TextEditingController _titleController;
  TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    detailProvider.setTitle = widget.note.title ?? "";
    detailProvider.setDetail = widget.note.detail ?? "";
    _isDeleted = widget.note.isDeleted;

    _titleController = TextEditingController(text: widget.note.title);
    _detailController = TextEditingController(text: widget.note.detail);

    final DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime noteDate = DateTime(
        widget.note.date.year, widget.note.date.month, widget.note.date.day);

    _date = now.difference(noteDate).inDays == 0
        ? DateFormat.jm("en_US").format(widget.note.date)
        : (now.difference(noteDate).inDays == 1
            ? "Yesterday, ${DateFormat.jm("en_US").format(widget.note.date)}"
            : (now.difference(noteDate).inDays > 1 &&
                    now.year - widget.note.date.year == 0
                ? DateFormat.MMMd("en_US").add_jm().format(widget.note.date)
                : DateFormat.yMMMd("en_US").add_jm().format(widget.note.date)));

    KeyboardVisibilityNotification().addNewListener(onHide: () {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    return Theme(
      data: ThemeData.dark().copyWith(
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: Theme.of(context).primaryColor,
        ),
        primaryColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        bottomAppBarColor: Theme.of(context).bottomAppBarColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UndoRedoProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => NoteDetailProvider(),
          ),
        ],
        child: WillPopScope(
          onWillPop: () async {
            NoteCreation.update(
                context: context,
                note: widget.note,
                title: detailProvider.getTitle,
                detail: detailProvider.getDetail,
                isDeleted: _isDeleted);

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
              titleController: _titleController,
              detailController: _detailController,
              onDelete: () {
                _isDeleted = true;

                Navigator.of(context)
                    .maybePop()
                    .then((value) => Navigator.maybePop(context));

                DeepToast.showToast(description: "Note moved to Trash Bin");
              },
              onCopy: () {
                if (detailProvider.getTitle.isNullEmptyOrWhitespace &&
                    detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  Navigator.of(context).pop();
                  DeepToast.showToast(description: "Cannot copy empty note");
                } else {
                  NoteCreation.create(
                      context: context,
                      title: detailProvider.getTitle,
                      detail: detailProvider.getDetail,
                      folderID: widget.note.folderID,
                      folderName: widget.note.folderName);

                  Navigator.of(context)
                      .maybePop()
                      .then((value) => Navigator.maybePop(context));

                  DeepToast.showToast(description: "Note copied successfully");
                }
              },
            ),
            body: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                DeepKeepAlive(
                  child: Padding(
                    padding: EdgeInsetsResponsive.fromLTRB(18, 0, 16, 16),
                    child: _titleField(data: widget.note),
                  ),
                ),
                DeepKeepAlive(
                  child: Padding(
                    padding: EdgeInsetsResponsive.fromLTRB(18, 16, 16, 16),
                    child: _detailField(widget.note),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleField({Note data}) {
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    detailProvider.checkTitleDirection = detailProvider.getTitle;

    return Selector<NoteDetailProvider, TextDirection>(
        selector: (context, provider) =>
            provider.getTitleDirection ? TextDirection.rtl : TextDirection.ltr,
        builder: (context, direction, child) {
          return TextField(
            controller: _titleController,
            textDirection: direction,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white70, fontSize: SizeHelper.getTitle),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              detailProvider.setTitle = value;

              if (detailProvider.isTextTyped == false) {
                detailProvider.setTextState = true;
              }

              detailProvider.checkTitleDirection = detailProvider.getTitle;

              if (undoRedoProvider.getCurrentFocus.isEmpty) {
                debugPrintSynchronously("this run");
                undoRedoProvider.setCurrentFocus = "title";
              } else if (undoRedoProvider.getCurrentFocus != "title") {
                undoRedoProvider.addUndo();
                undoRedoProvider.setCurrentFocus = "title";
              }

              if (undoRedoProvider.canUndo() == false &&
                  !value.isNullEmptyOrWhitespace) {
                debugPrintSynchronously('CAN UNDO');
                undoRedoProvider.setCanUndo = true;
              }

              /// Check for Latin characters
              if (value.contains("[\\s\\p{L}\\p{M}&&[^\\p{Alpha}]]+")) {
                if (value.endsWith(" ") && !value.isNullEmptyOrWhitespace) {
                  undoRedoProvider.addUndo();
                  undoRedoProvider.setCurrentTyped = value;
                } else {
                  undoRedoProvider.setCurrentTyped = value;
                }
              } else {
                if (_count == 4 && !value.isNullEmptyOrWhitespace) {
                  undoRedoProvider.addUndo();
                  undoRedoProvider.setCurrentTyped = value;
                  _count = 0;
                } else {
                  _count++;
                  debugPrintSynchronously("_count: $_count");
                  undoRedoProvider.setCurrentTyped = value;
                }
              }

              if (undoRedoProvider.canRedo()) {
                undoRedoProvider.clearRedo();
              }
            },
            decoration: InputDecoration.collapsed(
              hintText: 'Title',
            ),
          );
        });
  }

  Widget _detailField(Note data) {
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
            textDirection: direction,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white70, fontSize: SizeHelper.getDescription),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              detailProvider.setDetail = value;

              if (detailProvider.isTextTyped == false) {
                detailProvider.setTextState = true;
              }

              detailProvider.checkDetailDirection = detailProvider.getDetail;

              if (undoRedoProvider.getCurrentFocus.isEmpty) {
                undoRedoProvider.setCurrentFocus = "detail";
              } else if (undoRedoProvider.getCurrentFocus != "detail") {
                undoRedoProvider.addUndo();
                undoRedoProvider.setCurrentFocus = "detail";
              }

              if (undoRedoProvider.canUndo() == false &&
                  !value.isNullEmptyOrWhitespace) {
                undoRedoProvider.setCanUndo = true;
              }

              /// Check for Latin characters
              if (value.contains("[\\s\\p{L}\\p{M}&&[^\\p{Alpha}]]+")) {
                if (value.endsWith(" ") && !value.isNullEmptyOrWhitespace) {
                  undoRedoProvider.addUndo();
                  undoRedoProvider.setCurrentTyped = value;
                } else {
                  undoRedoProvider.setCurrentTyped = value;
                }
              } else {
                if (_count == 4 && !value.isNullEmptyOrWhitespace) {
                  undoRedoProvider.addUndo();
                  undoRedoProvider.setCurrentTyped = value;
                  _count = 1;
                } else {
                  _count++;
                  debugPrintSynchronously("_count: $_count");
                  undoRedoProvider.setCurrentTyped = value;
                }
              }

              if (undoRedoProvider.canRedo()) {
                undoRedoProvider.clearRedo();
              }
            },
            decoration: InputDecoration.collapsed(
              hintText: 'Write your note here...',
            ),
          );
        });
  }
}
