import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/note_page.dart';
import 'package:deep_paper/transition/fade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'deep_paper.dart';
import 'note/detailScreen/note_detail.dart';
import 'note/detailScreen/note_detail_update.dart';

Future<void> main() async {
  runApp(DeepPaperApp());
}

class DeepPaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DeepPaperDatabase>(
      create: (_) => DeepPaperDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            popupMenuTheme: PopupMenuThemeData(color: Color(0xff222222)),
            bottomSheetTheme:
                BottomSheetThemeData(modalBackgroundColor: Color(0xff222222)),
            cardColor: Color(0xff212121),
            primaryColor: Colors.black,
            backgroundColor: Colors.black,
            bottomAppBarColor: Colors.black,
            toggleableActiveColor: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
            textSelectionColor: Colors.blue[900],
            textSelectionHandleColor: Colors.blue[900],
            canvasColor: Colors.black,
            accentColor: Colors.blue[400],
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontFamily: "PT Serif",
                    color: Colors.white.withOpacity(0.80),
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
                subtitle2: TextStyle(
                    color: Colors.white.withOpacity(0.80), fontSize: 22.0),
                bodyText1: TextStyle(
                  color: Colors.white.withOpacity(0.80),
                  fontSize: 16.0,
                ),
                bodyText2: TextStyle(
                  fontFamily: "Noto Sans",
                  color: Colors.white.withOpacity(0.87),
                ))),
        title: 'Deep Paper',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return Fade(
                page: DeepPaper(),
                settings: settings,
              );
              break;
            case '/NoteDetail':
              return Fade(page: NoteDetail(), settings: settings);
              break;
            case '/NoteDetailUpdate':
              return Fade(page: NoteDetailUpdate(), settings: settings);
              break;
            case '/NotePage':
              return Fade(page: NotePage(), settings: settings);
              break;
            default:
              return Fade(page: DeepPaper(), settings: settings);
          }
        },
      ),
    );
  }
}
