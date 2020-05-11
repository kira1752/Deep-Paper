import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:deep_paper/note/widgets/note_card.dart';
import 'package:deep_paper/utility/deep_keep_alive.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

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
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            Illustration.getTrash,
                            width: SizeHelper.setWidth(size: 220.0),
                            height: SizeHelper.setHeight(size: 220.0),
                          ),
                          Padding(
                            padding: EdgeInsetsResponsive.only(top: 24.0),
                            child: Text(
                              "Your trash bin is clean",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white70,
                                      fontSize: SizeHelper.getHeadline5,
                                      fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
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
                      }),
        );
      }),
    );
  }
}
