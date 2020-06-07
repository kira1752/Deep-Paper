import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/note_page.dart';
import 'package:deep_paper/transition/fade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'deep_paper.dart';
import 'note/detailScreen/note_detail.dart';
import 'note/detailScreen/note_detail_update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
                color: Color(0xff202020),
                textStyle: TextStyle(color: Colors.white.withOpacity(0.80))),
            bottomSheetTheme: BottomSheetThemeData(
              modalBackgroundColor: Color(0xff202020),
            ),
            cardColor: Color(0xff202020).withOpacity(0.90),
            highlightColor: Color(0x424242),
            accentColor: Colors.orange[400], //#fdb368
            primaryColor: Color(0xff121212),
            backgroundColor: Color(0xff121212),
            bottomAppBarColor: Color(0xff121212),
            cursorColor: Colors.orange[900],
            scaffoldBackgroundColor: Color(0xff121212),
            textSelectionColor: Colors.orange[900],
            textSelectionHandleColor: Colors.orange[900],
            canvasColor: Color(0xff181818),
            textTheme: TextTheme(
                headline5: TextStyle(
                  fontFamily: "PT Serif",
                  fontFamilyFallback: ["Noto Color Emoji"],
                  color: Colors.white.withOpacity(0.80),
                  fontWeight: FontWeight.w600,
                ),
                headline6: TextStyle(
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
            case '/NoteDetail':
              return MaterialPageRoute(
                  builder: (context) => NoteDetail(), settings: settings);
              break;
            case '/NoteDetailUpdate':
              return Fade(
                  page: NoteDetailUpdate(settings.arguments),
                  settings: settings);
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
