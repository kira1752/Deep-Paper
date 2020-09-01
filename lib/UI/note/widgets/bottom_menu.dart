import 'package:deep_paper/UI/note/widgets/bottom_modal.dart';
import 'package:deep_paper/UI/note/widgets/undo_redo.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final TextEditingController detailController;
  final void Function() onDelete;
  final void Function() onCopy;
  final void Function() noteInfo;

  BottomMenu({@required this.detailController,
      @required this.onDelete,
      @required this.onCopy,
      @required this.noteInfo});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomAppBar(
          elevation: 0.0,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).viewInsets
                : const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    MyIcon.plus_square,
                    color: Theme.of(context).accentColor.withOpacity(0.80),
                  ),
                  onPressed: () async {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    await BottomModal.openAddMenu(context: context);
                  },
                ),
                UndoRedo(detailController: detailController),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).accentColor.withOpacity(0.80),
                  ),
                  onPressed: () async {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    await BottomModal.openOptionsMenu(
                        context: context,
                        onDelete: onDelete,
                        onCopy: onCopy,
                        noteInfo: noteInfo);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
