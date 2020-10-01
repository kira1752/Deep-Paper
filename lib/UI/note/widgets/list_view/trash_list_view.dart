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
      child: Consumer<List<Note>>(
          child: const EmptyTrashIllustration(),
          builder: (context, data, illustration) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: data.isNull
                    ? const SizedBox()
                    : data.isEmpty ? illustration : _TrashIsExist(data: data));
          }),
    );
  }
}

class _TrashIsExist extends StatefulWidget {
  final List<Note> data;

  const _TrashIsExist({@required this.data});

  @override
  __TrashIsExistState createState() => __TrashIsExistState();
}

class __TrashIsExistState extends State<_TrashIsExist> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final drawerProvider =
          Provider.of<NoteDrawerProvider>(context, listen: false);
      drawerProvider.setTrashExist = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        cacheExtent: 100,
        semanticChildCount: widget.data.length,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return NoteCard(
            key: ValueKey<int>(index),
            index: index,
            content: NoteCardContent(
              note: widget.data[index],
            ),
            note: widget.data[index],
            onTap: () {
              note_dialog.openRestoreDialog(
                  context: context, data: widget.data[index]);
            },
          );
        });
  }
}
