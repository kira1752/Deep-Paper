import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:deep_paper/note/widgets/empty_trash_illustration.dart';
import 'package:deep_paper/note/widgets/note_card.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class TrashListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllDeletedNotes(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: data.isNull
              ? const SizedBox()
              : data.isEmpty
                  ? EmptyTrashIllustration()
                  : CustomScrollView(
                      physics: ScrollPhysics(),
                      slivers: <Widget>[
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return DeepKeepAlive(
                              child: NoteCard(
                                key: ValueKey<int>(index),
                                index: index,
                                note: data[index],
                                ontap: () {
                                  BottomModal.openRestoreDialog(
                                      context: context, data: data[index]);
                                },
                              ),
                            );
                          },
                          childCount: data.length,
                        ))
                      ],
                    ),
        );
      }),
    );
  }
}
