import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/undo_redo.dart';
import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomMenu extends StatelessWidget {
  final String date;
  final bool newNote;
  final TextEditingController titleController;
  final TextEditingController detailController;
  final FocusNode titleFocus;
  final FocusNode detailFocus;
  final void Function() onDelete;
  final void Function() onCopy;

  BottomMenu(
      {@required this.date,
      @required this.newNote,
      @required this.titleController,
      @required this.detailController,
      @required this.titleFocus,
      @required this.detailFocus,
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
          Selector<UndoRedoProvider, bool>(
              selector: (context, provider) => provider.canUndo(),
              builder: (context, canUndo, widget) {
                debugPrintSynchronously("Undo rebuild");
                return IconButton(
                  icon: Icon(
                    Icons.undo,
                    color: canUndo
                        ? Colors.white.withOpacity(0.87)
                        : Colors.white38,
                  ),
                  onPressed: canUndo
                      ? () => UndoRedo.undo(
                          context: context,
                          titleController: titleController,
                          detailController: detailController,
                          titleFocus: titleFocus,
                          detailFocus: detailFocus)
                      : null,
                );
              }),
          Selector<UndoRedoProvider, bool>(
              selector: (context, provider) => provider.canRedo(),
              builder: (context, canRedo, widget) {
                debugPrintSynchronously("Redo rebuild");
                return IconButton(
                  icon: Icon(
                    Icons.redo,
                    color: canRedo
                        ? Colors.white.withOpacity(0.87)
                        : Colors.white38,
                  ),
                  onPressed: canRedo
                      ? () => UndoRedo.redo(
                          context: context,
                          titleController: titleController,
                          detailController: detailController,
                          titleFocus: titleFocus,
                          detailFocus: detailFocus)
                      : null,
                );
              })
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
