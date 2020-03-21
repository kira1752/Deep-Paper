import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomMenu extends StatelessWidget {
  final String date;
  final bool newNote;
  final void Function() onDelete;
  final void Function() onCopy;

  BottomMenu(
      {@required this.date,
      @required this.newNote,
      this.onDelete,
      this.onCopy});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              MyIcon.plus_square,
              color: Colors.white70,
            ),
            onPressed: () {
              _addMenu(context: context);
            },
          ),
          Selector<NoteDetailProvider, bool>(
              selector: (context, detailProvider) => detailProvider.isTextTyped,
              builder: (context, isTyped, child) {
                debugPrintSynchronously("Undo Redo Rebuild");
                return _textOrUndoRedo(
                    context: context, isTyped: isTyped, date: date);
              }),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white70,
            ),
            onPressed: () {
              _optionsMenu(context: context, newNote: newNote);
            },
          )
        ],
      ),
    );
  }

  Future _addMenu({@required BuildContext context}) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        context: context,
        builder: (context) {
          return ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    MyIcon.camera_alt_outline,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Take photo",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white70),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    MyIcon.photo_outline,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Choose image",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white70),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.mic_none,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Recording",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white70),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future _optionsMenu(
      {@required BuildContext context, @required bool newNote}) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        context: context,
        builder: (context) {
          return ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(18),
            children: <Widget>[
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  enabled: newNote ? false : true,
                  onTap: onDelete,
                  leading: Icon(
                    MyIcon.trash_empty,
                    color: newNote ? Colors.white30 : Colors.white70,
                  ),
                  title: Text(
                    "Delete",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: newNote ? Colors.white30 : Colors.white70),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  enabled: newNote ? false : true,
                  onTap: onCopy,
                  leading: Icon(
                    Icons.content_copy,
                    color: newNote ? Colors.white30 : Colors.white70,
                  ),
                  title: Text(
                    "Make a copy",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: newNote ? Colors.white30 : Colors.white70),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.color_lens,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Change color",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _textOrUndoRedo(
      {@required BuildContext context,
      @required bool isTyped,
      @required String date}) {
    if (isTyped) {
      return Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.undo,
              color: Colors.white70,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.redo, color: Colors.white70),
            onPressed: () {},
          )
        ],
      );
    } else {
      return Text(
        "$date",
        style: Theme.of(context).textTheme.bodyText2,
      );
    }
  }
}
