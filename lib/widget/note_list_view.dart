import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/provider/deep_bottom_provider.dart';
import 'package:deep_paper/provider/selection_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class NoteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final _database = Provider.of<DeepPaperDatabase>(context, listen: false);
    return StreamProvider<List<Note>>.value(
      value: _database.noteDao.watchAllNotes(),
      child: Consumer<List<Note>>(builder: (context, data, child) {
        if (data == null)
          return Container();
        else if (data.isEmpty) {
          return Center(
              child: Text(
            "CREATE NEW NOTE",
            style: Theme.of(context).textTheme.headline6,
          ));
        } else
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => Selector<
                    SelectionProvider, bool>(
                selector: (context, provider) =>
                    provider.getSelected.containsKey(index),
                builder: (context, selected, child) {
                  debugPrintSynchronously("note $index rebuild");
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Material(
                      color: Color(0xff212121),
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
                          padding: EdgeInsets.all(18),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (!data[index].title.isNullEmptyOrWhitespace)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "${data[index].title}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.80)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                if (!data[index].detail.isNullEmptyOrWhitespace)
                                  Text(
                                    "${data[index].detail}",
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

  Widget _dateAndIcons(
      {@required BuildContext context, @required Note data}) {
    final String date = DateFormat.yMMMd('en_US').add_jm().format(data.date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 6),
          child: Text(
            "$date",
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontFamily: "Noto Sans",
                  color: Colors.white60
                ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 6),
            child: Icon(
              MyIcon.photo_outline,
              color: Colors.white60,
              size: 16,
            )),
        Icon(
          Icons.mic_none,
          color: Colors.white60,
          size: 16,
        )
      ],
    );
  }
}
