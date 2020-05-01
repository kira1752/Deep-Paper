import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/note/widgets/bottom_menu.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteDetail extends StatefulWidget {
  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  String _title = "";
  String _detail = "";

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
    final FolderNoteData folder = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<NoteDetailProvider>(
      create: (_) => NoteDetailProvider(),
      child: WillPopScope(
        onWillPop: () async {
          NoteCreation.create(
            context: context,
            title: _title,
            detail: _detail,
            folderID: folder.isNotNull ? folder.id : null,
          );

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
          bottomNavigationBar: BottomMenu(date: _date, newNote: true),
          body: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 0, 16, 16),
                  child: _titleField(),
                ),
              ),
              DeepKeepAlive(
                child: Padding(
                  padding: EdgeInsetsResponsive.fromLTRB(18, 16, 16, 16),
                  child: _detailField(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white70, fontSize: SizeHelper.getTitle),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  _title = value;

                  if (Provider.of<NoteDetailProvider>(context, listen: false)
                          .isTextTyped ==
                      false) {
                    Provider.of<NoteDetailProvider>(context, listen: false)
                        .setTextState = true;
                  }

                  Provider.of<DetectTextDirectionProvider>(context,
                          listen: false)
                      .checkDirection = _title;
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
              return TextField(
                controller: textControllerProvider.controller,
                textDirection: direction,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white70, fontSize: SizeHelper.getDescription),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  _detail = value;

                  if (Provider.of<NoteDetailProvider>(context, listen: false)
                          .isTextTyped ==
                      false) {
                    Provider.of<NoteDetailProvider>(context, listen: false)
                        .setTextState = true;
                  }

                  Provider.of<DetectTextDirectionProvider>(context,
                          listen: false)
                      .checkDirection = _detail;
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
