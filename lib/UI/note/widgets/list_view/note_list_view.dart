import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../data/deep.dart';
import '../../../../utility/deep_route_string.dart';
import '../../../../utility/extension.dart';
import '../empty_note_illustration.dart';
import '../note_card.dart';

class NoteListView extends StatelessWidget {
  const NoteListView();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllNotes(),
      builder: (context, _) {
        final listNote = context.watch<List<Note>>();

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: listNote.isNull
              ? const SizedBox()
              : listNote.isEmpty
                  ? const EmptyNoteIllustration()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      cacheExtent: 100,
                      semanticChildCount: listNote.length,
                      itemCount: listNote.length,
                      itemBuilder: (context, index) {
                        return NoteCard(
                          key: ValueKey<int>(index),
                          index: index,
                          content: NoteCardContent(
                            note: listNote[index],
                          ),
                          note: listNote[index],
                          onTap: () {
                            Navigator.pushNamed(
                                    context, DeepRouteString.noteDetail,
                                    arguments: listNote[index])
                                .then((value) =>
                                    fabProvider.setScrollDown = false);
                          },
                        );
                      }),
        );
      },
    );
  }
}
