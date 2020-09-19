import 'dart:async';

import '../../utility/extension.dart';
import 'provider/undo_redo_provider.dart';

class NoteDetailDebounce {
  Timer debounce;

  void run(UndoRedoProvider undoRedoProvider) {
    if (debounce?.isActive ?? false) debounce.cancel();
    debounce = Timer(const Duration(milliseconds: 1000), () {
      final value = undoRedoProvider.currentTyped.value;
      if (!value.isNullEmptyOrWhitespace &&
          undoRedoProvider.getUndoLastValue() != value &&
          undoRedoProvider.getRedoLastValue() != value) {
        undoRedoProvider.addUndo();
        undoRedoProvider.currentTyped.value = null;
        undoRedoProvider.currentCursorPosition = null;
      }
    });
  }

  void dispose() => debounce?.cancel();
}
