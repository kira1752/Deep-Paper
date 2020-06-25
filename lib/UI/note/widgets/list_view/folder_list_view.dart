import 'package:deep_paper/UI/note/widgets/empty_note_illustration.dart';
import 'package:deep_paper/UI/note/widgets/note_card.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class FolderListView extends StatelessWidget {
  final FolderNoteData folder;

  FolderListView({Key key, @required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchNoteInsideFolder(folder),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: data.isNull
              ? const SizedBox()
              : data.isEmpty
                  ? EmptyNoteIllustration()
                  : ListView.builder(
            cacheExtent: 100,
                      physics: ScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return NoteCard(
                          key: ValueKey<int>(index),
                          index: index,
                          note: data[index],
                          ontap: () {
                            Navigator.of(context).pushNamed(
                                "/NoteDetailUpdate",
                                arguments: data[index]);
                          },
                        );
                      }),
        );
      }),
    );
  }
}
