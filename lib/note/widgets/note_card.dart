import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/utility/detect_text_direction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';

typedef void _OnTap();

class NoteCard extends StatelessWidget {
  final int index;
  final Note note;
  final _OnTap ontap;

  NoteCard({@required this.index, @required this.note, @required this.ontap});

  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);

    return Selector<SelectionProvider, bool>(
        key: ValueKey<int>(index),
        selector: (context, provider) =>
            provider.getSelected.containsKey(index),
        builder: (context, selected, child) {
          debugPrintSynchronously("note $index rebuild");
          return Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
            child: Material(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: selectionProvider.getSelection && selected
                      ? BorderSide(
                          color: Theme.of(context).accentColor, width: 2.0)
                      : BorderSide.none),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  debugPrint("Note $index Tapped");
                  if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(key: index, note: note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: index);

                    if (selectionProvider.getSelected.length == 0) {
                      Provider.of<DeepBottomProvider>(context, listen: false)
                          .setSelection = false;
                      selectionProvider.setSelection = false;
                    }
                  } else
                    ontap();
                },
                onLongPress: () {
                  if (!selectionProvider.getSelection) {
                    selectionProvider.setSelected(key: index, note: note);

                    Provider.of<DeepBottomProvider>(context, listen: false)
                        .setSelection = true;

                    selectionProvider.setSelection = true;
                  } else if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(key: index, note: note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: index);

                    if (selectionProvider.getSelected.length == 0) {
                      Provider.of<DeepBottomProvider>(context, listen: false)
                          .setSelection = false;
                      selectionProvider.setSelection = false;
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListBody(children: <Widget>[
                    if (!note.title.isNullEmptyOrWhitespace)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          "${note.title}",
                          textDirection:
                              DetectTextDirection.isRTL(text: "${note.title}")
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.white.withOpacity(0.80),
                              fontSize: 22.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (!note.detail.isNullEmptyOrWhitespace)
                      Text(
                        "${note.detail}",
                        textDirection:
                            DetectTextDirection.isRTL(text: "${note.detail}")
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white70, fontSize: 18.0),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (note.containAudio || note.containImage)
                      Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: _dateAndIcons(context: context, data: note)),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  Widget _dateAndIcons({@required BuildContext context, @required Note data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (data.containImage)
          Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                MyIcon.photo_outline,
                color: Colors.white60,
                size: 18,
              )),
        if (data.containAudio)
          Icon(
            Icons.mic_none,
            color: Colors.white60,
            size: 18,
          )
      ],
    );
  }
}
