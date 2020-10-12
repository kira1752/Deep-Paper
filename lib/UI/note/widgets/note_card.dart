import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../business_logic/note/provider/fab_provider.dart';
import '../../../business_logic/note/provider/selection_provider.dart';
import '../../../data/deep.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../transition/widgets/slide_right_widget.dart';

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

  BorderRadius calculateNoteCardBorderRadius(
      {@required int listLength, @required int index}) {
    if (listLength == 1) {
      return const BorderRadius.all(Radius.circular(12.0));
    } else if (index == 0) {
      return const BorderRadius.only(
          topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0));
    } else if (listLength - 1 == index) {
      return const BorderRadius.only(
          bottomRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0));
    } else {
      return const BorderRadius.all(Radius.circular(0.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final listLength = context.watch<List<Note>>().length;

    final noteSelected = context.select(
        (SelectionProvider value) => value.getSelected.containsKey(index));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.5),
      child: Material(
        color: noteSelected
            ? Theme.of(context).accentColor.withOpacity(.22)
            : Theme.of(context).canvasColor,
        animationDuration: const Duration(milliseconds: 300),
        shape: RoundedRectangleBorder(
            borderRadius: calculateNoteCardBorderRadius(
                listLength: listLength, index: index),
            side: BorderSide.none),
        child: InkWell(
            borderRadius: calculateNoteCardBorderRadius(
                listLength: listLength, index: index),
            splashColor: Theme.of(context).accentColor.withOpacity(.16),
            onTap: () {
              final readNoteSelected = context
                  .read<SelectionProvider>()
                  .getSelected
                  .containsKey(index);

              if (!readNoteSelected &&
                  context.read<SelectionProvider>().getSelection) {
                final selectionProvider = context.read<SelectionProvider>();

                selectionProvider.setSelected(key: index, note: note);
              } else if (readNoteSelected &&
                  context.read<SelectionProvider>().getSelection) {
                final selectionProvider = context.read<SelectionProvider>();
                final deepBottomProvider = context.read<BottomNavBarProvider>();
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

              if (!context.read<SelectionProvider>().getSelection) {
                final selectionProvider = context.read<SelectionProvider>();
                final deepBottomProvider = context.read<BottomNavBarProvider>();

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
                final deepBottomProvider = context.read<BottomNavBarProvider>();
                final fabProvider = context.read<FABProvider>();

                selectionProvider.remove(key: index);

                if (selectionProvider.getSelected.isEmpty) {
                  deepBottomProvider.setSelection = false;
                  selectionProvider.setSelection = false;
                  fabProvider.setScrollDown = false;
                }
              }
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Row(
                children: [
                  SlideRightWidget(
                    duration: const Duration(milliseconds: 250),
                    child: noteSelected
                        ? Material(
                      color: Theme
                          .of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                      type: MaterialType.circle,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          FluentIcons.checkmark_20_filled,
                          size: 16.0,
                          color: noteSelected
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ),
                  Expanded(child: content),
                ],
              ),
            )),
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: widget.note.detailDirection,
          children: <Widget>[
            Text(
              '${widget.note.detail}',
              textDirection: widget.note.detailDirection,
              strutStyle: const StrutStyle(leading: 0.7),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(
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
                          FluentIcons.image_24_filled,
                          color:
                          themeColorOpacity(context: context, opacity: .7),
                          size: SizeHelper.setIconSize(size: 20.0),
                        ),
                      ),
                    if (widget.note.containAudio)
                      Icon(
                        FluentIcons.mic_on_24_filled,
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
                      FluentIcons.folder_24_filled,
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
                      maxLines: 1,
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
    );
  }
}
