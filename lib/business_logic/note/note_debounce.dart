import '../../utility/debounce.dart';
import '../../utility/extension.dart';
import 'provider/undo_history_provider.dart';

class DetailFieldDebounce {
  final Debounce _debounce = Debounce();

  void run(UndoHistoryProvider undoRedoProvider) {
    _debounce.run(const Duration(milliseconds: 1000), () {
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

  void cancel() => _debounce.cancel();
}
