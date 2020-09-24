import 'dart:async';

import '../../utility/extension.dart';
import 'provider/undo_redo_provider.dart';

class NoteDetailDebounce {
  Timer _debounce;

  void run(UndoRedoProvider undoRedoProvider) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final value = undoRedoProvider.currentTyped;
      if (!value.isNullEmptyOrWhitespace &&
          undoRedoProvider.getUndoCurrentTyped() != value &&
          undoRedoProvider.getRedoCurrentTyped() != value) {
        undoRedoProvider.addUndo();
        undoRedoProvider.currentTyped = null;
        undoRedoProvider.currentCursorPosition = null;
      }
    });
  }

  void cancel() => _debounce?.cancel();
}
