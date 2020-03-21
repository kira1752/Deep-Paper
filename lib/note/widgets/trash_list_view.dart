import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/utility/detect_text_direction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TrashListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final _database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>.value(
      value: _database.noteDao.allDeletedNotesTemp(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        if (data == null)
          return Container();
        else if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  MyIcon.trash_empty,
                  size: 120,
                  color: Colors.white70,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Text(
                    "No notes in Trash Bin",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white70),
                  ),
                )
              ],
            ),
          );
        } else
          return ScrollablePositionedList.builder(
            physics: ClampingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => Selector<
                    SelectionProvider, bool>(
                key: ValueKey<int>(index),
                selector: (context, provider) =>
                    provider.getSelected.containsKey(index),
                builder: (context, selected, child) {
                  debugPrintSynchronously("note $index rebuild");
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Material(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: selectionProvider.getSelection && selected
                              ? BorderSide(color: Colors.blue[400], width: 2.0)
                              : BorderSide.none),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          debugPrint("Note $index Tapped");
                          if (!selected && selectionProvider.getSelection) {
                            selectionProvider.setSelected(
                                key: index, note: data[index]);
                          } else if (selected &&
                              selectionProvider.getSelection) {
                            selectionProvider.remove(key: index);
                          } else {
                            Navigator.pushNamed(context, '/NoteDetailUpdate',
                                arguments: data[index]);
                          }
                        },
                        onLongPress: () {
                          if (!selectionProvider.getSelection) {
                            selectionProvider.setSelected(
                                key: index, note: data[index]);
                            Provider.of<DeepBottomProvider>(context,
                                    listen: false)
                                .setSelection = true;
                            selectionProvider.setSelection = true;
                          } else if (!selected &&
                              selectionProvider.getSelection) {
                            selectionProvider.setSelected(
                                key: index, note: data[index]);
                          } else if (selected &&
                              selectionProvider.getSelection) {
                            selectionProvider.remove(key: index);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: ListBody(children: <Widget>[
                            if (!data[index].title.isNullEmptyOrWhitespace)
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: Text(
                                  "${data[index].title}",
                                  textDirection: DetectTextDirection.isRTL(
                                          text: "${data[index].title}")
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color:
                                              Colors.white.withOpacity(0.80)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (!data[index].detail.isNullEmptyOrWhitespace)
                              Text(
                                "${data[index].detail}",
                                textDirection: DetectTextDirection.isRTL(
                                        text: "${data[index].detail}")
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.white70),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Padding(
                                padding: EdgeInsets.only(top: 24),
                                child: _dateAndIcons(
                                    context: context, data: data[index])),
                          ]),
                        ),
                      ),
                    ),
                  );
                }),
          );
      }),
    );
  }

  Widget _dateAndIcons({@required BuildContext context, @required Note data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              MyIcon.photo_outline,
              color: Colors.white60,
              size: 18,
            )),
        Icon(
          Icons.mic_none,
          color: Colors.white60,
          size: 18,
        )
      ],
    );
  }
}
