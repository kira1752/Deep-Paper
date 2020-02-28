import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/screen/note_page.dart';
import 'package:deep_paper/transition/fade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detailScreen/note_detail.dart';
import 'deep_paper.dart';

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
        theme: ThemeData.from(
            colorScheme: ColorScheme(
              primary: const Color(0xffbb86fc),
              primaryVariant: const Color(0xff3700B3),
              secondary: const Color(0xff121212),
              secondaryVariant: const Color(0xff121212),
              surface: const Color(0xff121212),
              background: const Color(0xff121212),
              error: const Color(0xffcf6679),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.white,
              onBackground: Colors.white,
              onError: Colors.black,
              brightness: Brightness.dark,
            ),
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontFamily: "Open Sans",
                    color: Colors.white.withOpacity(0.87),
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
                subtitle2: TextStyle(
                    fontFamily: "Open Sans",
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0),
                bodyText1: TextStyle(
                    fontFamily: "Open Sans",
                    color: Colors.white70,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
                bodyText2: TextStyle(
                    fontFamily: "Open Sans",
                    color: Colors.white70,
                    fontWeight: FontWeight.w600))),
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
