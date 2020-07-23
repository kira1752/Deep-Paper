import 'package:deep_paper/UI/note/widgets/deep_dialog.dart';
import 'package:deep_paper/UI/note/widgets/empty_trash_illustration.dart';
import 'package:deep_paper/UI/note/widgets/note_card.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    : _TrashIsExist(data: data));
      }),
    );
  }
}

class _TrashIsExist extends StatefulWidget {
  final List<Note> data;

  _TrashIsExist({@required this.data});

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
        cacheExtent: 100,
        physics: ScrollPhysics(),
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return NoteCard(
            key: ValueKey<int>(index),
            index: index,
            note: widget.data[index],
            onTap: () {
              DeepDialog.openRestoreDialog(
                  context: context, data: widget.data[index]);
            },
          );
        });
  }
}
