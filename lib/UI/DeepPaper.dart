import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import '../business_logic/note/note_debounce.dart';
import '../business_logic/note/text_field_logic.dart' as text_field_logic;
import '../business_logic/provider/note/note_detail_provider.dart';
import '../business_logic/provider/note/undo_history_provider.dart';
import '../business_logic/provider/note/undo_state_provider.dart';
import '../data/deep.dart';
import '../model/note/undo_model.dart';
import '../resource/string_resource.dart';
import '../utility/deep_route_string.dart';
import 'note/detailScreen/note_detail.dart';
import 'style/app_theme.dart' as app_theme;
import 'transition/deep_route.dart';
import 'widgets/main_nav.dart';

class DeepPaper extends StatelessWidget {
  const DeepPaper();

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
        themeMode: ThemeMode.dark,
        title: 'Deep Paper',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case DeepRouteString.deepPaper:
              return DeepRoute(
                builder: (_) => const MainNav(),
                settings: settings,
              );
            case DeepRouteString.noteCreate:
              final FolderNoteData folder = settings.arguments;
              final folderName = folder?.name;
              final folderID = folder?.id;

              return DeepRoute(
                maintainState: false,
                builder: (_) => MultiProvider(providers: [
                  Provider<DetailFieldDebounce>(
                    create: (_) => DetailFieldDebounce(),
                    dispose: (_, debounce) => debounce.cancel(),
                  ),
                  StateNotifierProvider<UndoStateProvider, UndoModel>(
                    create: (_) => UndoStateProvider(),
                  ),
                  ProxyProvider<UndoStateProvider, UndoHistoryProvider>(
                    update: (_, undoStateProvider, __) =>
                        UndoHistoryProvider(undoStateProvider),
                  ),
                  ChangeNotifierProvider<NoteDetailProvider>(
                      create: (_) => NoteDetailProvider(
                            note: null,
                            folderID: folderID ?? 0,
                            folderName: folderName ?? StringResource.mainFolder,
                            date: text_field_logic.loadDateAsync(null),
                          )),
                ], child: const NoteDetail()),
                settings: settings,
              );
              break;
            case DeepRouteString.noteDetail:
              final Note note = settings.arguments;
              final folderID = note.folderID;
              final folderName = note.folderName;

              return DeepRoute(
                  maintainState: false,
                  builder: (_) => MultiProvider(providers: [
                        Provider<DetailFieldDebounce>(
                          create: (_) => DetailFieldDebounce(),
                          dispose: (_, debounce) => debounce.cancel(),
                        ),
                        StateNotifierProvider<UndoStateProvider, UndoModel>(
                          create: (_) => UndoStateProvider(),
                        ),
                        ProxyProvider<UndoStateProvider, UndoHistoryProvider>(
                          update: (_, undoStateProvider, __) =>
                              UndoHistoryProvider(undoStateProvider),
                        ),
                        ChangeNotifierProvider<NoteDetailProvider>(
                            create: (_) => NoteDetailProvider(
                                  note: note,
                                  folderID: folderID,
                                  folderName: folderName,
                                  date: text_field_logic
                                      .loadDateAsync(note.modified),
                                )),
                      ], child: const NoteDetail()),
                  settings: settings);
              break;
            default:
              return DeepRoute(
                  builder: (_) => const MainNav(), settings: settings);
              break;
          }
        },
      ),
    );
  }
}
