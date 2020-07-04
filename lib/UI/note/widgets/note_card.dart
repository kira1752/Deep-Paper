import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef void _OnTap();

class NoteCard extends StatefulWidget {
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
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);

    return Selector<SelectionProvider, bool>(
        selector: (context, provider) =>
            provider.getSelected.containsKey(widget.index),
        builder: (context, selected, child) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 12),
            child: Material(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: selectionProvider.getSelection && selected
                      ? BorderSide(
                          color: Theme.of(context).accentColor, width: 2.0)
                      : BorderSide.none),
              child: InkWell(
                borderRadius: BorderRadius.circular(6.0),
                onTap: () {
                  if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: widget.index);

                    if (selectionProvider.getSelected.length == 0) {
                      Provider.of<DeepBottomProvider>(context, listen: false)
                          .setSelection = false;
                      selectionProvider.setSelection = false;
                    }
                  } else
                    widget.ontap();
                },
                onLongPress: () {
                  if (!selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);

                    Provider.of<DeepBottomProvider>(context, listen: false)
                        .setSelection = true;

                    selectionProvider.setSelection = true;
                  } else if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: widget.index);

                    if (selectionProvider.getSelected.length == 0) {
                      Provider.of<DeepBottomProvider>(context, listen: false)
                          .setSelection = false;
                      selectionProvider.setSelection = false;
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: widget.note.detailDirection,
                      children: <Widget>[
                        Text(
                          "${widget.note.detail}",
                          textDirection: widget.note.detailDirection,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white70,
                              fontSize: SizeHelper.getDescription),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: _labelDateAndIcons(
                                context: context, note: widget.note)),
                      ]),
                ),
              ),
            ),
          );
        });
  }

  Widget _labelDateAndIcons(
      {@required BuildContext context, @required Note note}) {
    return Wrap(
      spacing: SizeHelper.setWidth(size: 14.0),
      runSpacing: SizeHelper.setHeight(size: 14.0),
      textDirection: note.detailDirection,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
                width: 2.0,
                color: Theme.of(context).accentColor.withOpacity(0.5)),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            curve: Curves.decelerate,
            vsync: this,
            child: Text(
              "${note.folderName}",
              textDirection: note.folderNameDirection,
              style: Theme
                  .of(context)
                  .textTheme
                  .caption,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (note.containImage || note.containAudio)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (note.containImage)
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    MyIcon.photo_outline,
                    color: Colors.white70,
                    size: SizeHelper.setIconSize(size: 20.0),
                  ),
                ),
              if (note.containAudio)
                Icon(
                  Icons.mic_none,
                  color: Colors.white70,
                  size: SizeHelper.setIconSize(size: 20.0),
                )
            ],
          )
      ],
    );
  }
}
