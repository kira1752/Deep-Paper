import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: BottomAppBar(
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
              onPressed: () async {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
                await BottomModal.openAddMenu(context: context);
              },
            ),
            Selector<NoteDetailProvider, bool>(
                selector: (context, detailProvider) =>
                    detailProvider.isTextTyped,
                builder: (context, isTyped, child) {
                  return _textOrUndoRedo(
                      context: context, isTyped: isTyped, date: date);
                }),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
              onPressed: () async {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
                await BottomModal.openOptionsMenu(
                    context: context,
                    newNote: newNote,
                    onDelete: onDelete,
                    onCopy: onCopy);
              },
            )
          ],
        ),
      ),
    );
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
