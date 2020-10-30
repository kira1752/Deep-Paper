import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/bottom_menu_logic.dart';
import '../../../../business_logic/note/provider/note_detail_provider.dart';
import 'bottom_modal.dart';
import 'undo_redo.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu();

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
                  padding: EdgeInsets.zero,
                  icon: Material(
                    color: Theme.of(context).accentColor.withOpacity(.16),
                    type: MaterialType.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        FluentIcons.add_24_regular,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (FocusScope.of(context).hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    await openAddMenu(context: context);
                  },
                ),
                const UndoRedo(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Material(
                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(.16),
                    type: MaterialType.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        FluentIcons.more_vertical_24_regular,
                        color: Theme
                            .of(context)
                            .accentColor,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (FocusScope
                        .of(context)
                        .hasFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    await openOptionsMenu(
                        context: context,
                        onDelete: () => onDelete(context: context),
                        onCopy: () => onCopy(context: context),
                        noteInfo: () =>
                            noteInfo(
                              context: context,
                              folderName:
                              context
                                  .read<NoteDetailProvider>()
                                  .folderName,
                            ));
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
