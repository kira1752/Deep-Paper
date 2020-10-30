import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/note_drawer_provider.dart';
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
                    : _TrashIsExist(ListNote: listNote));
      },
    );
  }
}

class _TrashIsExist extends StatefulWidget {
  final List<Note> ListNote;

  const _TrashIsExist({@required this.ListNote});

  @override
  __TrashIsExistState createState() => __TrashIsExistState();
}

class __TrashIsExistState extends State<_TrashIsExist> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteDrawerProvider>().setTrashExist = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        cacheExtent: 100,
        semanticChildCount: widget.ListNote.length,
        itemCount: widget.ListNote.length,
        itemBuilder: (context, index) {
          return NoteCard(
            key: ValueKey<int>(index),
            index: index,
            content: NoteCardContent(
              note: widget.ListNote[index],
            ),
            note: widget.ListNote[index],
            onTap: () {
              note_dialog.openRestoreDialog(
                  context: context, data: widget.ListNote[index]);
            },
          );
        });
  }
}
