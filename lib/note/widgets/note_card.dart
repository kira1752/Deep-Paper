import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

typedef void _OnTap();

class NoteCard extends StatelessWidget {
  final int index;
  final Note note;
  final _OnTap ontap;

  NoteCard(
      {Key key,
      @required this.index,
      @required this.note,
      @required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);

    return Selector<SelectionProvider, bool>(
        selector: (context, provider) =>
            provider.getSelected.containsKey(index),
        builder: (context, selected, child) {
          debugPrintSynchronously("note $index rebuild");
          return Padding(
            padding: EdgeInsetsResponsive.only(
                left: 16, right: 16, bottom: 12, top: 12),
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
                  padding: EdgeInsetsResponsive.all(20),
                  child: ListBody(children: <Widget>[
                    if (!note.title.isNullEmptyOrWhitespace)
                      Padding(
                        padding: EdgeInsetsResponsive.only(bottom: 12),
                        child: Text(
                          "${note.title}",
                          textDirection: note.titleDirection,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white.withOpacity(0.80),
                              fontSize: SizeHelper.getTitle),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (!note.detail.isNullEmptyOrWhitespace)
                      Text(
                        "${note.detail}",
                        textDirection: note.detailDirection,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white70,
                            fontSize: SizeHelper.getDescription),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Padding(
                        padding: EdgeInsetsResponsive.only(top: 24.0),
                        child: _dateAndIcons(context: context, note: note)),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  Widget _dateAndIcons({@required BuildContext context, @required Note note}) {
    return Wrap(
      spacing: 8.0,
      textDirection:
          note.detail.isEmpty ? note.titleDirection : note.detailDirection,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsetsResponsive.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
                width: 2.0,
                color: Theme.of(context).accentColor.withOpacity(0.3)),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Text(
            "${note.folderName}",
            textDirection: note.folderNameDirection,
            style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white70, fontSize: SizeHelper.getFolder),
            maxLines: 1,
          ),
        ),
        if (note.containImage)
          Icon(
            MyIcon.photo_outline,
            color: Colors.white60,
            size: SizeHelper.setIconSize(size: 20.0),
          ),
        if (note.containAudio)
          Icon(
            Icons.mic_none,
            color: Colors.white60,
            size: SizeHelper.setIconSize(size: 20.0),
          )
      ],
    );
  }
}
