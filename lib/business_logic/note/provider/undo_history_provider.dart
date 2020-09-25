import 'dart:collection';

import '../../../utility/extension.dart';
import '../model/text_model.dart';
import 'undo_state_provider.dart';

class UndoHistoryProvider {
  int currentCursorPosition = 0;
  String currentTyped = '';

  /// To store temp value of cursor when user tapping text field
  /// or when user creating new note
  int tempInitCursor;
  int initialCursorPosition;
  String initialDetail;
  UndoStateProvider undoStateProvider;

  final Queue<TextModel> _undo = Queue();
  final Queue<TextModel> _redo = Queue();

  UndoHistoryProvider(this.undoStateProvider);

  void addUndo() {
    final model = TextModel(
        currentTyped: currentTyped,
        currentCursorPosition: currentCursorPosition);

    _undo.add(model);
  }

  TextModel undo() {
    if (currentTyped.isNull) {
      // If user typing state is already saved because of debounce
      // then, user click undo button.
      // pop the latest value from _undo queue and save it to
      // _redo queue
      _redo.add(_undo.removeLast());
    } else if (currentTyped.isNotNull && _redo.isEmpty) {
      // If when user typing, then suddenly user tap Undo button
      // and debounce isn't running properly (not quick enough to save
      // the typing state),
      // save currentTyped to _redo queue
      if (_undo.isNotEmpty) {
        if (_undo.last.currentTyped != currentTyped) {
          final model = TextModel(
              currentTyped: currentTyped,
              currentCursorPosition: currentCursorPosition);

          _redo.add(model);
        }
      } else {
        final model = TextModel(
            currentTyped: currentTyped,
            currentCursorPosition: currentCursorPosition);

        _redo.add(model);
      }
    }

    if (_undo.isNotEmpty) {
      if (_undo.last.currentTyped == currentTyped) {
        _redo.add(_undo.removeLast());
      }

      if (_undo.isNotEmpty) {
        final model = _undo.removeLast();

        currentTyped = model.currentTyped;
        currentCursorPosition = model.currentCursorPosition;

        if (undoStateProvider.canRedo == false) {
          undoStateProvider.toggleRedo();
        }

        _redo.add(model);

        return model;
      } else {
        final model = TextModel(
            currentTyped: initialDetail,
            currentCursorPosition: initialCursorPosition);

        currentTyped = null;
        currentCursorPosition = null;

        if (undoStateProvider.canUndo) {
          undoStateProvider.toggleUndo();
        }

        if (undoStateProvider.canRedo == false) {
          undoStateProvider.toggleRedo();
        }

        return model;
      }
    } else {
      final model = TextModel(
          currentTyped: initialDetail,
          currentCursorPosition: initialCursorPosition);

      currentTyped = null;
      currentCursorPosition = null;

      if (undoStateProvider.canUndo) {
        undoStateProvider.toggleUndo();
      }

      if (undoStateProvider.canRedo == false) {
        undoStateProvider.toggleRedo();
      }

      return model;
    }
  }

  TextModel redo() {
    TextModel model;
    if (_redo.last.currentTyped == currentTyped) {
      _undo.add(_redo.removeLast());
    }

    if (_redo.isNotEmpty) {
      model = _redo.removeLast();
      currentTyped = model.currentTyped;
      currentCursorPosition = model.currentCursorPosition;

      _undo.add(model);
    }

    if (undoStateProvider.canUndo == false) {
      undoStateProvider.toggleUndo();
    }

    if (_redo.isEmpty && undoStateProvider.canRedo) {
      undoStateProvider.toggleRedo();
    }

    return model;
  }

  String getUndoCurrentTyped() {
    if (_undo.isEmpty) {
      return initialDetail;
    } else {
      return _undo.last.currentTyped;
    }
  }

  String getRedoCurrentTyped() {
    if (_redo.isEmpty) {
      return initialDetail;
    } else {
      return _redo.last.currentTyped;
    }
  }

  void clearRedo() {
    _redo.clear();
  }

  bool isUndoEmptyAndCheckLength() {
    return _undo.isEmpty && _undo.length != 1;
  }

  bool isUndoEmpty() {
    return _undo.isEmpty;
  }

  bool isRedoEmpty() {
    return _redo.isEmpty;
  }
}
