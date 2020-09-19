import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../business_logic/note/provider/note_detail_provider.dart';
import '../business_logic/note/provider/undo_redo_provider.dart';
import '../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../data/deep.dart';
import '../utility/deep_route_string.dart';
import 'app_theme.dart' as app_theme;
import 'deep_paper.dart';
import 'note/detailScreen/note_detail.dart';
import 'note/note_page.dart';

// ignore: public_member_api_docs
class DeepMaterialApp extends StatelessWidget {
  const DeepMaterialApp();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DeepPaperDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: app_theme.dark(),
        title: 'Deep Paper',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case DeepRouteString.deepPaper:
              return MaterialPageRoute(
                builder: (context) => const DeepPaper(),
                settings: settings,
              );
            case DeepRouteString.noteCreate:
              final FolderNoteData folder = settings.arguments;
              final folderName = folder?.name;
              final folderID = folder?.id;

              return MaterialPageRoute(
                builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => UndoRedoProvider()),
                      ChangeNotifierProvider(
                          create: (context) => NoteDetailProvider())
                    ],
                    child: NoteDetail(
                      folderID: folderID,
                      folderName: folderName,
                      note: null,
                      date: text_field_logic.loadDateAsync(null),
                    )),
                settings: settings,
              );
              break;
            case DeepRouteString.noteDetail:
              final Note note = settings.arguments;
              final folderID = note.folderID;
              final folderName = note.folderName;

              return MaterialPageRoute(
                  builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (context) => UndoRedoProvider()),
                            ChangeNotifierProvider(
                                create: (context) => NoteDetailProvider())
                          ],
                          child: NoteDetail(
                            note: note,
                            folderID: folderID,
                            folderName: folderName,
                            date: text_field_logic.loadDateAsync(note.modified),
                          )),
                  settings: settings);
              break;
            case DeepRouteString.notePage:
              return MaterialPageRoute(
                  builder: (context) => const NotePage(), settings: settings);
              break;
            default:
              return MaterialPageRoute(
                  builder: (context) => const DeepPaper(), settings: settings);
              break;
          }
        },
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
