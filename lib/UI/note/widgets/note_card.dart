import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
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
  final _OnTap onTap;

  NoteCard(
      {Key key,
      @required this.index,
      @required this.note,
      @required this.onTap})
      : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final deepBottomProvider =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);
    return Selector<SelectionProvider, bool>(
        selector: (context, provider) =>
            provider.getSelected.containsKey(widget.index),
        builder: (context, selected, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Material(
              color: Theme.of(context).cardColor,
              animationDuration: Duration(milliseconds: 300),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: selectionProvider.getSelection && selected
                      ? BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.70),
                          width: 3.0)
                      : BorderSide.none),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                splashColor: Theme.of(context).accentColor.withOpacity(.16),
                onTap: () {
                  if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: widget.index);

                    if (selectionProvider.getSelected.length == 0) {
                      deepBottomProvider.setSelection = false;
                      selectionProvider.setSelection = false;
                      fabProvider.setScrollDown = false;
                    }
                  } else {
                    widget.onTap();
                  }
                },
                onLongPress: () {
                  if (!selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);

                    deepBottomProvider.setSelection = true;

                    selectionProvider.setSelection = true;
                  } else if (!selected && selectionProvider.getSelection) {
                    selectionProvider.setSelected(
                        key: widget.index, note: widget.note);
                  } else if (selected && selectionProvider.getSelection) {
                    selectionProvider.remove(key: widget.index);

                    if (selectionProvider.getSelected.length == 0) {
                      deepBottomProvider.setSelection = false;
                      selectionProvider.setSelection = false;
                      fabProvider.setScrollDown = false;
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: widget.note.detailDirection,
                      children: <Widget>[
                        Text(
                          "${widget.note.detail}",
                          textDirection: widget.note.detailDirection,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: SizeHelper.getDetail),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 24.0),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
                width: 2.0,
                color: Theme.of(context).accentColor.withOpacity(0.5)),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeIn,
            vsync: this,
            child: Text(
              "${note.folderName}",
              textDirection: note.folderNameDirection,
              style: Theme.of(context).textTheme.caption,
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
                  padding: const EdgeInsets.only(right: 8.0),
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
