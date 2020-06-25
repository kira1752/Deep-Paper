import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/deep_paper.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail_update.dart';
import 'package:deep_paper/UI/note/note_page.dart';
import 'package:deep_paper/UI/transition/deep_route.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/undo_redo_provider.dart';
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
              page: DeepPaper(),
              settings: settings,
            );
          case '/NoteDetail':
            return DeepRoute(
              page: MultiProvider(providers: [
                ChangeNotifierProvider(create: (context) => UndoRedoProvider()),
                ChangeNotifierProvider(
                    create: (context) => NoteDetailProvider())
              ], child: NoteDetail()),
              settings: settings,
            );
            break;
          case '/NoteDetailUpdate':
            return DeepRoute(
                page: MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) => UndoRedoProvider()),
                  ChangeNotifierProvider(
                      create: (context) => NoteDetailProvider())
                ], child: NoteDetailUpdate(settings.arguments)),
                settings: settings);
            break;
          case '/NotePage':
            return DeepRoute(page: NotePage(), settings: settings);
            break;
          default:
            return DeepRoute(page: DeepPaper(), settings: settings);
        }
      },
    );
  }
}
