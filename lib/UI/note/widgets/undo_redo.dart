import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/note/model/undo_model.dart';
import '../../../business_logic/note/note_debounce.dart';
import '../../../business_logic/note/provider/note_detail_provider.dart';
import '../../../business_logic/note/provider/undo_history_provider.dart';
import '../../../business_logic/note/provider/undo_state_provider.dart';
import '../../../business_logic/note/undo_redo.dart' as undo_redo;
import '../../../business_logic/provider/TextControllerValue.dart';
import '../../app_theme.dart';

class UndoRedo extends StatelessWidget {
  const UndoRedo();

  @override
  Widget build(BuildContext context) {
    return context.select((NoteDetailProvider provider) => provider.isTextTyped)
        ? const UndoRedoButton()
        : const SizedBox();
  }
}

class UndoRedoButton extends StatelessWidget {
  const UndoRedoButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            FluentIcons.arrow_undo_24_filled,
            color: context.select((UndoModel value) => value.canUndo)
                ? Theme.of(context).accentColor.withOpacity(.87)
                : themeColorOpacity(context: context, opacity: .38),
          ),
          onPressed: context.select((UndoModel value) => value.canUndo)
              ? () {
            context.read<NoteDetailDebounce>().cancel();
            undo_redo.undo(
              detailProvider: context.read<NoteDetailProvider>(),
              undoStateProvider: context.read<UndoStateProvider>(),
              undoHistoryProvider: context.read<UndoHistoryProvider>(),
              detailController: context.read<TextControllerValue>().value,
            );
          }
              : null,
        ),
        IconButton(
          icon: Icon(
            FluentIcons.arrow_redo_24_filled,
            color: context.select((UndoModel value) => value.canRedo)
                ? Theme
                .of(context)
                .accentColor
                .withOpacity(.87)
                : themeColorOpacity(context: context, opacity: .38),
          ),
          onPressed: context.select((UndoModel value) => value.canRedo)
              ? () {
            context.read<NoteDetailDebounce>().cancel();
            undo_redo.redo(
              detailProvider: context.read<NoteDetailProvider>(),
              undoStateProvider: context.read<UndoStateProvider>(),
              undoHistoryProvider: context.read<UndoHistoryProvider>(),
              detailController: context.read<TextControllerValue>().value,
            );
          }
              : null,
        )
      ],
    );
  }
}
