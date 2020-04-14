import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class _LocalStore {
  String _title = "";
  String _detail = "";
  bool _isDeleted;

  String get getTitle => _title;
  String get getDetail => _detail;
  bool get isDeleted => _isDeleted;

  set setTitle(String title) => _title = title;
  set setDetail(String detail) => _detail = detail;
  set setDeleted(bool isDeleted) => _isDeleted = isDeleted;
}

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final _LocalStore _local = _LocalStore();

  final String _date = DateFormat.jm('en_US').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(onHide: () {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrintSynchronously("Note Detail Rebuild");

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () {
          return _saveNote(context: context);
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
          bottomNavigationBar: BottomMenu(date: _date, newNote: true),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 16, 16),
                child: _titleField(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: _detailField(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _saveNote({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final String title = _local.getTitle;
    final String detail = _local.getDetail;
    final TextDirection titleDirection = Bidi.detectRtlDirectionality(title)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final TextDirection detailDirection = Bidi.detectRtlDirectionality(detail)
        ? TextDirection.rtl
        : TextDirection.ltr;
    final FolderNoteData folder = ModalRoute.of(context).settings.arguments;
    final int folderId = folder.isNotNull ? folder.id : null;

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

    return true;
  }

  Widget _titleField() {
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

                  Provider.of<DetectTextDirectionProvider>(context,
                          listen: false)
                      .checkDirection = _local.getTitle;

                  _local.setTitle = value;
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Title',
                ),
              );
            });
      }),
    );
  }

  Widget _detailField() {
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
        return Selector<DetectTextDirectionProvider, TextDirection>(
            selector: (context, provider) =>
                provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
            builder: (context, direction, child) {
              debugPrintSynchronously("Detail Field rebuild");
              return SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? (MediaQuery.of(context).size.height) / 2
                        : MediaQuery.of(context).size.height / 3,
                child: TextField(
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
                ),
              );
            });
      }),
    );
  }
}
