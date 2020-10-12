import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../data/deep.dart';
import '../../../../utility/extension.dart';
import '../dialog/note_dialog.dart' as note_dialog;
import '../empty_trash_illustration.dart';
import '../note_card.dart';

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
                    : _TrashIsExist(ListNote: listNote));
      },
    );
  }
}

class _TrashIsExist extends StatelessWidget {
  final List<Note> ListNote;

  const _TrashIsExist({@required this.ListNote});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final drawerProvider =
          Provider.of<NoteDrawerProvider>(context, listen: false);
      drawerProvider.setTrashExist = true;
    });

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        cacheExtent: 100,
        semanticChildCount: ListNote.length,
        itemCount: ListNote.length,
        itemBuilder: (context, index) {
          return NoteCard(
            key: ValueKey<int>(index),
            index: index,
            content: NoteCardContent(
              note: ListNote[index],
            ),
            note: ListNote[index],
            onTap: () {
              note_dialog.openRestoreDialog(
                  context: context, data: ListNote[index]);
            },
          );
        });
  }
}
