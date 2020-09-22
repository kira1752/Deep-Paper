import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../business_logic/note/provider/fab_provider.dart';
import '../../../business_logic/note/provider/selection_provider.dart';
import '../../../data/deep.dart';
import '../../../icons/my_icon.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';

class NoteCard extends StatefulWidget {
  final int index;
  final Note note;
  final void Function() onTap;

  const NoteCard(
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
      builder: (context, selected, noteCardContent) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Material(
          color: selectionProvider.getSelection && selected
              ? Theme.of(context).accentColor.withOpacity(0.12)
              : Theme.of(context).cardColor.withOpacity(.87),
          animationDuration: const Duration(milliseconds: 300),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: selectionProvider.getSelection && selected
                  ? BorderSide(
                      color: Theme.of(context).accentColor.withOpacity(0.54),
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

                  if (selectionProvider.getSelected.isEmpty) {
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

                  if (selectionProvider.getSelected.isEmpty) {
                    deepBottomProvider.setSelection = false;
                    selectionProvider.setSelection = false;
                    fabProvider.setScrollDown = false;
                  }
                }
              },
              child: noteCardContent),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: widget.note.detailDirection,
            children: <Widget>[
              Text(
                '${widget.note.detail}',
                textDirection: widget.note.detailDirection,
                strutStyle: const StrutStyle(leading: 0.7),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getDetail),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.note.containImage || widget.note.containAudio)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (widget.note.containImage)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            MyIcon.image,
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            size: SizeHelper.setIconSize(size: 20.0),
                          ),
                        ),
                      if (widget.note.containAudio)
                        Icon(
                          Icons.mic_none,
                          color:
                              themeColorOpacity(context: context, opacity: .7),
                          size: SizeHelper.setIconSize(size: 20.0),
                        )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  textDirection: widget.note.detailDirection,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Icon(
                        MyIcon.folder,
                        color: Theme
                            .of(context)
                            .accentColor
                            .withOpacity(.7),
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeIn,
                      vsync: this,
                      child: Text(
                        '${widget.note.folderName}',
                        textDirection: widget.note.folderNameDirection,
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            .copyWith(
                          color: themeColorOpacity(
                              context: context, opacity: .7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
