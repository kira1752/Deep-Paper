import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/deep.dart';
import '../../../../utility/extension.dart';
import '../empty_trash_illustration.dart';
import '../note_card.dart';
import '../note_dialog.dart' as note_dialog;

class TrashListView extends StatelessWidget {
  const TrashListView();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllDeletedNotes(),
      builder: (context, _) {
        final listNote = context.watch<List<Note>>();

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            child: listNote.isNull
                ? const SizedBox()
                : listNote.isEmpty
                    ? const EmptyTrashIllustration()
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
                              note_dialog.openRestoreDialog(
                                  context: context, data: listNote[index]);
                            },
                          );
                        }));
      },
    );
  }
}
