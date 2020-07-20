import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/deep_paper.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail.dart';
import 'package:deep_paper/UI/note/note_page.dart';
import 'package:deep_paper/UI/transition/deep_route.dart';
import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeepMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      title: 'Deep Paper',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return DeepRoute(
              page: (context) => DeepPaper(),
              settings: settings,
            );
          case '/NoteCreate':
            final FolderNoteData folder = settings.arguments;
            final String folderName =
                folder.isNotNull ? folder.name : "Main folder";
            final int folderID = folder.isNotNull ? folder.id : 0;

            return DeepRoute(
              page: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (context) => UndoRedoProvider()),
                    ChangeNotifierProvider(
                        create: (context) => NoteDetailProvider())
                  ],
                  child: NoteDetail(
                      folderID: folderID, folderName: folderName, note: null)),
              settings: settings,
            );
            break;
          case '/NoteDetail':
            final Note note = settings.arguments;
            final int folderID = note.folderID;
            final String folderName = note.folderName;

            return DeepRoute(
                page: (context) => MultiProvider(
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
                        )),
                settings: settings);
            break;
          case '/NotePage':
            return DeepRoute(page: (context) => NotePage(), settings: settings);
            break;
          default:
            return DeepRoute(
                page: (context) => DeepPaper(), settings: settings);
        }
      },
    );
  }
}
