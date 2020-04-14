import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/extension.dart'
    show TextUtilsStringExtension;

class LocalStore {
  String title = "";
  String detail = "";
  bool isDeleted = false;

  LocalStore(
      {@required this.title, @required this.detail, @required this.isDeleted});

  String get getTitle => title;
  String get getDetail => detail;
  bool get getIsDeleted => isDeleted;

  set setTitle(String title) => title = title;
  set setDetail(String detail) => detail = detail;
  set setDeleted(bool isDeleted) => isDeleted = isDeleted;
}

class NoteDetailUpdate extends StatefulWidget {
  final Note data;

  NoteDetailUpdate(this.data);

  @override
  _NoteDetailUpdateState createState() => _NoteDetailUpdateState();
}

class _NoteDetailUpdateState extends State<NoteDetailUpdate> {
  LocalStore _local;
  TextEditingController _titleController;
  TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _local = LocalStore(
        title: widget.data.title ?? "",
        detail: widget.data.detail ?? "",
        isDeleted: widget.data.isDeleted);

    _titleController = TextEditingController(text: widget.data.title);
    _detailController = TextEditingController(text: widget.data.detail);

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
    debugPrintSynchronously("Note Detail Rebuild");

    final DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime noteDate = DateTime(
        widget.data.date.year, widget.data.date.month, widget.data.date.day);

    final String date = now.difference(noteDate).inDays == 0
        ? DateFormat.jm("en_US").format(widget.data.date)
        : (now.difference(noteDate).inDays == 1
            ? "Yesterday, ${DateFormat.jm("en_US").format(widget.data.date)}"
            : (now.difference(noteDate).inDays > 1 &&
                    now.year - widget.data.date.year == 0
                ? DateFormat.MMMd("en_US").add_jm().format(widget.data.date)
                : DateFormat.yMMMd("en_US").add_jm().format(widget.data.date)));

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () {
          return _saveNote(context, widget.data);
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
            date: date,
            newNote: false,
            onDelete: () {
              _local.setDeleted = true;
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();

              DeepToast.showToast(description: "Note moved to Trash Bin");
            },
            onCopy: () {
              _makeCopy(context: context);
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();

              DeepToast.showToast(description: "Note copied successfully");
            },
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 16, 16),
                child: _titleField(data: widget.data),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: _detailField(widget.data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _saveNote(BuildContext context, Note data) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final String title = _local.getTitle;
    final String detail = _local.getDetail;
    final TextDirection titleDirection = Bidi.detectRtlDirectionality(title)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final TextDirection detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final bool isDeleted = _local.isDeleted;

    debugPrintSynchronously("Title: $title");
    debugPrintSynchronously("Detail: $detail");

    if (data.title != title ||
        data.detail != detail && data.isDeleted != isDeleted) {
      debugPrintSynchronously("run");
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        await database.noteDao.updateNote(data.copyWith(
            title: title,
            detail: detail,
            titleDirection: titleDirection,
            detailDirection: detailDirection,
            isDeleted: isDeleted,
            date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        await database.noteDao.deleteNote(data);
      }
    } else if (data.title != title || data.detail != detail) {
      debugPrintSynchronously("run");
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        await database.noteDao.updateNote(data.copyWith(
            title: title,
            detail: detail,
            titleDirection: titleDirection,
            detailDirection: detailDirection,
            date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        await database.noteDao.deleteNote(data);
      }
    } else if (data.isDeleted != isDeleted) {
      await database.noteDao.updateNote(data.copyWith(
        isDeleted: isDeleted,
      ));
    }

    return true;
  }

  Future<void> _makeCopy({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final String title = _local.getTitle;
    final String detail = _local.getDetail;
    final TextDirection titleDirection = Bidi.detectRtlDirectionality(title)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final TextDirection detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final int folderId = widget.data.id.isNotNull ? widget.data.id : null;

    debugPrintSynchronously("Title: $title");
    debugPrintSynchronously("Detail: $detail");
    debugPrintSynchronously("Folder ID: $folderId");

    if (!title.isNullEmptyOrWhitespace && !detail.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(NotesCompanion(
          title: Value(title),
          detail: Value(detail),
          titleDirection: Value(titleDirection),
          detailDirection: Value(detailDirection),
          folderID: Value(folderId),
          date: Value(DateTime.now())));
    } else if (!title.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(NotesCompanion(
          title: Value(title),
          titleDirection: Value(titleDirection),
          folderID: Value(folderId),
          date: Value(DateTime.now())));
    } else if (!detail.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(NotesCompanion(
          detail: Value(detail),
          detailDirection: Value(detailDirection),
          folderID: Value(folderId),
          date: Value(DateTime.now())));
    }
  }

  Widget _titleField({Note data}) {
    return ChangeNotifierProvider(
      create: (context) => DetectTextDirectionProvider(),
      child: Selector<DetectTextDirectionProvider, TextDirection>(
          selector: (context, provider) =>
              provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
          builder: (context, direction, child) {
            debugPrintSynchronously("Title Field rebuild");

            Provider.of<DetectTextDirectionProvider>(context, listen: false)
                .checkDirection = _local.getTitle;

            return TextField(
              controller: _titleController,
              textDirection: direction,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.white70, fontSize: 22.0),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                if (Provider.of<NoteDetailProvider>(context, listen: false)
                        .isTextTyped ==
                    false) {
                  Provider.of<NoteDetailProvider>(context, listen: false)
                      .setTextState = true;
                }

                _local.setTitle = value;
                Provider.of<DetectTextDirectionProvider>(context, listen: false)
                    .checkDirection = _local.getTitle;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Title',
              ),
            );
          }),
    );
  }

  Widget _detailField(Note data) {
    return ChangeNotifierProvider(
      create: (context) => DetectTextDirectionProvider(),
      child: Selector<DetectTextDirectionProvider, TextDirection>(
          selector: (context, provider) =>
              provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
          builder: (context, direction, child) {
            Provider.of<DetectTextDirectionProvider>(context, listen: false)
                .checkDirection = _local.getDetail;

            return SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? (MediaQuery.of(context).size.height) / 2
                  : MediaQuery.of(context).size.height / 3,
              child: TextField(
                expands: true,
                controller: _detailController,
                textDirection: direction,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white70, fontSize: 18.0),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  if (Provider.of<NoteDetailProvider>(context, listen: false)
                          .isTextTyped ==
                      false) {
                    Provider.of<NoteDetailProvider>(context, listen: false)
                        .setTextState = true;
                  }

                  _local.setDetail = value;
                  Provider.of<DetectTextDirectionProvider>(context,
                          listen: false)
                      .checkDirection = _local.getDetail;
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Write your note here...',
                ),
              ),
            );
          }),
    );
  }
}
