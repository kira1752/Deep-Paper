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
      child: Consumer<List<Note>>(
          child: const EmptyNoteIllustration(),
          builder: (context, data, illustration) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              child: data.isNull
                  ? const SizedBox()
                  : data.isEmpty
                      ? illustration
                      : ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          cacheExtent: 100,
                          semanticChildCount: data.length,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return NoteCard(
                              key: ValueKey<int>(index),
                              index: index,
                              note: data[index],
                              onTap: () {
                                Navigator.pushNamed(
                                        context, DeepRouteString.noteDetail,
                                        arguments: data[index])
                                    .then((value) =>
                                        fabProvider.setScrollDown = false);
                              },
                            );
                          }),
            );
          }),
    );
  }
}
