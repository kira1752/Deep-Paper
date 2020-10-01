import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../business_logic/note/provider/fab_provider.dart';
import '../../../business_logic/note/provider/selection_provider.dart';
import '../../../data/deep.dart';
import '../../../icons/my_icon.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';

class NoteCard extends StatelessWidget {
  final int index;
  final Widget content;
  final Note note;
  final void Function() onTap;

  NoteCard(
      {Key key,
      @required this.index,
      @required this.content,
      @required this.note,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteSelected = context.select(
            (SelectionProvider value) => value.getSelected.containsKey(index));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: noteSelected
            ? Theme
            .of(context)
            .accentColor
            .withOpacity(0.12)
            : Theme
            .of(context)
            .cardColor
            .withOpacity(.87),
        animationDuration: const Duration(milliseconds: 300),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: noteSelected
                ? BorderSide(
                    color: Theme.of(context).accentColor.withOpacity(0.54),
                    width: 3.0)
                : BorderSide.none),
        child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            splashColor: Theme.of(context).accentColor.withOpacity(.16),
            onTap: () {
              final readNoteSelected = context
                  .read<SelectionProvider>()
                  .getSelected
                  .containsKey(index);

              if (!readNoteSelected &&
                  context
                      .read<SelectionProvider>()
                      .getSelection) {
                final selectionProvider = context.read<SelectionProvider>();

                selectionProvider.setSelected(key: index, note: note);
              } else if (readNoteSelected &&
                  context
                      .read<SelectionProvider>()
                      .getSelection) {
                final selectionProvider = context.read<SelectionProvider>();
                final deepBottomProvider = context.read<DeepBottomProvider>();
                final fabProvider = context.read<FABProvider>();

                selectionProvider.remove(key: index);

                if (selectionProvider.getSelected.isEmpty) {
                  deepBottomProvider.setSelection = false;
                  selectionProvider.setSelection = false;
                  fabProvider.setScrollDown = false;
                }
              } else {
                onTap();
              }
            },
            onLongPress: () {
              final readNoteSelected = context
                  .read<SelectionProvider>()
                  .getSelected
                  .containsKey(index);

              if (!context
                  .read<SelectionProvider>()
                  .getSelection) {
                final selectionProvider = context.read<SelectionProvider>();
                final deepBottomProvider = context.read<DeepBottomProvider>();

                selectionProvider.setSelected(key: index, note: note);

                deepBottomProvider.setSelection = true;

                selectionProvider.setSelection = true;
              } else if (!readNoteSelected &&
                  context.read<SelectionProvider>().getSelection) {
                final selectionProvider = context.read<SelectionProvider>();

                selectionProvider.setSelected(key: index, note: note);
              } else if (readNoteSelected &&
                  context.read<SelectionProvider>().getSelection) {
                final selectionProvider = context.read<SelectionProvider>();
                final deepBottomProvider = context.read<DeepBottomProvider>();
                final fabProvider = context.read<FABProvider>();

                selectionProvider.remove(key: index);

                if (selectionProvider.getSelected.isEmpty) {
                  deepBottomProvider.setSelection = false;
                  selectionProvider.setSelection = false;
                  fabProvider.setScrollDown = false;
                }
              }
            },
            child: content),
      ),
    );
  }
}

class NoteCardContent extends StatefulWidget {
  final Note note;

  const NoteCardContent({@required this.note});

  @override
  _NoteCardContentState createState() => _NoteCardContentState();
}

class _NoteCardContentState extends State<NoteCardContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          color:
                              themeColorOpacity(context: context, opacity: .7),
                          size: SizeHelper.setIconSize(size: 20.0),
                        ),
                      ),
                    if (widget.note.containAudio)
                      Icon(
                        Icons.mic_none,
                        color: themeColorOpacity(context: context, opacity: .7),
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
                      color: Theme.of(context).accentColor.withOpacity(.7),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                    vsync: this,
                    child: Text(
                      '${widget.note.folderName}',
                      textDirection: widget.note.folderNameDirection,
                      style: Theme.of(context).textTheme.caption.copyWith(
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
    );
  }
}
