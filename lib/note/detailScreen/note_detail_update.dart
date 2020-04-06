import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart'
    show TextUtilsStringExtension;

class _LocalStore {
  String _title = "";
  String _detail = "";
  bool _isDeleted = false;

  String get getTitle => _title;
  String get getDetail => _detail;
  bool get isDeleted => _isDeleted;

  set setTitle(String title) => _title = title;
  set setDetail(String detail) => _detail = detail;
  set setDeleted(bool isDeleted) => _isDeleted = isDeleted;
}

class NoteDetailUpdate extends StatelessWidget {
  final _LocalStore _local = _LocalStore();

  @override
  Widget build(BuildContext context) {
    Note data = ModalRoute.of(context).settings.arguments;
    _local.setTitle = data.title ?? "";
    _local.setDetail = data.detail ?? "";
    _local.setDeleted = data.isDeleted;

    debugPrintSynchronously("Note Detail Rebuild");

    final DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final DateTime noteDate =
        DateTime(data.date.year, data.date.month, data.date.day);

    final String date = now.difference(noteDate).inDays == 0
        ? DateFormat.jm("en_US").format(data.date)
        : (now.difference(noteDate).inDays == 1
            ? "Yesterday, ${DateFormat.jm("en_US").format(data.date)}"
            : (now.difference(noteDate).inDays > 1 &&
                    now.year - data.date.year == 0
                ? DateFormat.MMMd("en_US").add_jm().format(data.date)
                : DateFormat.yMMMd("en_US").add_jm().format(data.date)));

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () {
          return _saveNote(context, data);
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

              Fluttertoast.showToast(
                  msg: "Note moved to Trash Bin",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.white.withOpacity(0.87),
                  fontSize: 16,
                  backgroundColor: Color(0xff222222));
            },
            onCopy: () {
              _makeCopy(context: context);
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();

              Fluttertoast.showToast(
                  msg: "Note copied successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.white.withOpacity(0.87),
                  fontSize: 16,
                  backgroundColor: Color(0xff222222));
            },
          ),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 16, 16),
                child: _titleField(data: data),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: _detailField(data),
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
            isDeleted: isDeleted,
            date: DateTime.now()));
      } else if (title.isNullEmptyOrWhitespace &&
          detail.isNullEmptyOrWhitespace) {
        await database.noteDao.deleteNote(data);
      }
    } else if (data.title != title || data.detail != detail) {
      debugPrintSynchronously("run");
      if (!title.isNullEmptyOrWhitespace || !detail.isNullEmptyOrWhitespace) {
        await database.noteDao.updateNote(
            data.copyWith(title: title, detail: detail, date: DateTime.now()));
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

    debugPrintSynchronously("Title: $title");
    debugPrintSynchronously("Detail: $detail");

    if (!title.isNullEmptyOrWhitespace && !detail.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(NotesCompanion(
          title: Value(title),
          detail: Value(detail),
          date: Value(DateTime.now())));
    } else if (!title.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(
          NotesCompanion(title: Value(title), date: Value(DateTime.now())));
    } else if (!detail.isNullEmptyOrWhitespace) {
      await database.noteDao.insertNote(
          NotesCompanion(detail: Value(detail), date: Value(DateTime.now())));
    }
  }

  Widget _titleField({Note data}) {
    return MultiProvider(
      providers: [
        Provider<TextControllerProvider>(
          create: (context) => TextControllerProvider(),
          dispose: (context, provider) => provider.controller.dispose(),
        ),
        ChangeNotifierProvider(
            create: (context) => DetectTextDirectionProvider())
      ],
      child: Consumer<TextControllerProvider>(
          builder: (context, textControllerProvider, child) {
        textControllerProvider.controller.text = data.title;

        Provider.of<DetectTextDirectionProvider>(context, listen: false)
            .checkDirection = _local.getTitle;

        return Selector<DetectTextDirectionProvider, TextDirection>(
            selector: (context, provider) =>
                provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
            builder: (context, direction, child) {
              debugPrintSynchronously("Title Field rebuild");
              return TextField(
                controller: textControllerProvider.controller,
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
                  Provider.of<DetectTextDirectionProvider>(context,
                          listen: false)
                      .checkDirection = _local.getTitle;
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Title',
                ),
              );
            });
      }),
    );
  }

  Widget _detailField(Note data) {
    return MultiProvider(
      providers: [
        Provider<TextControllerProvider>(
          create: (context) => TextControllerProvider(),
          dispose: (context, provider) => provider.controller.dispose(),
        ),
        ChangeNotifierProvider(
            create: (context) => DetectTextDirectionProvider())
      ],
      child: Consumer<TextControllerProvider>(
          builder: (context, textControllerProvider, child) {
        debugPrintSynchronously("Detail Field rebuild");
        textControllerProvider.controller.text = data.detail;

        Provider.of<DetectTextDirectionProvider>(context, listen: false)
            .checkDirection = _local.getDetail;

        return Selector<DetectTextDirectionProvider, TextDirection>(
            selector: (context, provider) =>
                provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
            builder: (context, direction, child) {
              return TextField(
                controller: textControllerProvider.controller,
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
              );
            });
      }),
    );
  }
}
