import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/note_page.dart';
import 'package:deep_paper/transition/slide.dart';
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
            popupMenuTheme: PopupMenuThemeData(
                color: Color(0xff222222),
                textStyle: TextStyle(
                    fontFamily: "Noto Sans",
                    color: Colors.white.withOpacity(0.80))),
            bottomSheetTheme: BottomSheetThemeData(
              modalBackgroundColor: Color(0xff222222),
            ),
            cardColor: Color(0x212121).withOpacity(0.90),
            highlightColor: Color(0x424242),
            accentColor: Color(0xff5EA3DE),
            primaryColor: Colors.black,
            backgroundColor: Colors.black,
            bottomAppBarColor: Colors.black,
            toggleableActiveColor: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
            textSelectionColor: Colors.blue[900],
            textSelectionHandleColor: Colors.blue[900],
            canvasColor: Colors.black,
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontFamily: "PT Serif",
                    fontFamilyFallback: ["Noto Color Emoji"],
                    color: Colors.white.withOpacity(0.80),
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
                subtitle2: TextStyle(
                  wordSpacing: 1.0,
                  height: 1.5,
                  color: Colors.white.withOpacity(0.80),
                ),
                bodyText1: TextStyle(
                  wordSpacing: 1.0,
                  height: 1.5,
                  color: Colors.white.withOpacity(0.80),
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
              return Slide(
                page: DeepPaper(),
                settings: settings,
              );
            case '/NoteDetail':
              return Slide(page: NoteDetail(), settings: settings);
              break;
            case '/NoteDetailUpdate':
              return Slide(page: NoteDetailUpdate(), settings: settings);
              break;
            case '/NotePage':
              return Slide(page: NotePage(), settings: settings);
              break;
            default:
              return Slide(page: DeepPaper(), settings: settings);
          }
        },
      ),
    );
  }
}
