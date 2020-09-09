import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/deep_paper.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail.dart';
import 'package:deep_paper/UI/note/note_page.dart';
import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/deep_route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeepMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DeepPaperDatabase(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: AppTheme.dark(),
        defaultTransition: Transition.cupertino,
        title: 'Deep Paper',
        initialRoute: '/',
        getPages: [
          GetPage(name: DeepRouteString.deepPaper, page: () => DeepPaper()),
          GetPage(name: DeepRouteString.notePage, page: () => NotePage()),
          GetPage(
            name: DeepRouteString.noteCreate,
            page: () => MultiProvider(providers: [
              ChangeNotifierProvider(create: (context) => UndoRedoProvider()),
              ChangeNotifierProvider(create: (context) => NoteDetailProvider())
            ], child: const NoteDetail()),
          ),
          GetPage(
            name: DeepRouteString.noteDetail,
            page: () => MultiProvider(providers: [
              ChangeNotifierProvider(create: (context) => UndoRedoProvider()),
              ChangeNotifierProvider(create: (context) => NoteDetailProvider())
            ], child: const NoteDetail()),
          )
        ],
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
