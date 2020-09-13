import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../business_logic/note/provider/note_detail_provider.dart';
import '../business_logic/note/provider/undo_redo_provider.dart';
import '../data/deep.dart';
import '../utility/deep_route_string.dart';
import 'app_theme.dart';
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
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: AppTheme.dark(),
        defaultTransition: Transition.cupertino,
        title: 'Deep Paper',
        initialRoute: '/',
        getPages: [
          GetPage(
              name: DeepRouteString.deepPaper, page: () => const DeepPaper()),
          GetPage(name: DeepRouteString.notePage, page: () => const NotePage()),
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
