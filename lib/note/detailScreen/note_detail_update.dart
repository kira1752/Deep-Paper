import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/business_logic/text_field_logic.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _detailController;
  FocusNode _detailFocus;

  @override
  void initState() {
    super.initState();
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    detailProvider.setDetail = widget.note.detail ?? "";
    undoRedoProvider.setInitialDetail = widget.note.detail ?? "";
    _isDeleted = widget.note.isDeleted;
    _detailController = TextEditingController(text: widget.note.detail);
    _detailFocus = FocusNode();

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
    _detailController.dispose();
    _detailFocus.dispose();
    super.dispose();
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
        value: SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Theme.of(context).bottomAppBarColor,
        ),
        child: WillPopScope(
          onWillPop: () async {
            NoteCreation.update(
                context: context,
                note: widget.note,
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
              detailController: _detailController,
              onDelete: () {
                _isDeleted = true;

                NoteCreation.update(
                    context: context,
                    note: widget.note,
                    detail: detailProvider.getDetail,
                    isDeleted: _isDeleted);

                Navigator.of(context).popUntil(ModalRoute.withName("/"));

                DeepToast.showToast(description: "Note moved to Trash Bin");
              },
              onCopy: () {
                if (detailProvider.getDetail.isNullEmptyOrWhitespace) {
                  Navigator.of(context).pop();
                  DeepToast.showToast(description: "Cannot copy empty note");
                } else {
                  NoteCreation.create(
                      context: context,
                      detail: detailProvider.getDetail,
                      folderID: widget.note.folderID,
                      folderName: widget.note.folderName);

                  NoteCreation.update(
                      context: context,
                      note: widget.note,
                      detail: detailProvider.getDetail,
                      isDeleted: _isDeleted);

                  Navigator.of(context).popUntil(ModalRoute.withName("/"));

                  DeepToast.showToast(description: "Note copied successfully");
                }
              },
            ),
            body: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                DeepKeepAlive(
                  child: Padding(
                    padding: EdgeInsetsResponsive.fromLTRB(18, 24, 16, 16),
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
