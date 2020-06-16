import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/deep_paper.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail.dart';
import 'package:deep_paper/UI/note/detailScreen/note_detail_update.dart';
import 'package:deep_paper/UI/note/note_page.dart';
import 'package:deep_paper/UI/transition/slide.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(DeepPaperApp());

class DeepPaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DeepPaperDatabase>(
      create: (_) => DeepPaperDatabase(),
      child: OrientationBuilder(
        builder: (context, orientation) =>
            LayoutBuilder(builder: (context, constraints) {
          SizeConfig().init(constraints, orientation);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().dark(),
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
                  return Slide(
                    page: NoteDetail(),
                    settings: settings,
                  );
                  break;
                case '/NoteDetailUpdate':
                  return Slide(
                      page: NoteDetailUpdate(settings.arguments),
                      settings: settings);
                  break;
                case '/NotePage':
                  return Slide(page: NotePage(), settings: settings);
                  break;
                default:
                  return Slide(page: DeepPaper(), settings: settings);
              }
            },
          );
        }),
      ),
    );
  }
}
