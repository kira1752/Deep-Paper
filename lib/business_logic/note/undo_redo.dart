import 'package:flutter/widgets.dart';

import 'provider/note_detail_provider.dart';
import 'provider/undo_redo_provider.dart';
import 'text_field_logic.dart';

class UndoRedoBusinessLogic {
  UndoRedoBusinessLogic._();

  static Future<void> undo({
    @required UndoRedoProvider undoRedoProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController,
  }) async {
    final cursorOffset = undoRedoProvider.popUndoCursor();

    detailController.text = undoRedoProvider.popUndoValue();
    detailController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorOffset));

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
    detailProvider.setDetailCountNotify =
        await TextFieldLogic.countAllAsync(detailProvider.getDetail);
  }

  static Future<void> redo(
      {@required UndoRedoProvider undoRedoProvider,
      @required NoteDetailProvider detailProvider,
      @required TextEditingController detailController}) async {
    final cursorOffset = undoRedoProvider.popRedoCursor();

    detailController.text = undoRedoProvider.popRedoValue();
    detailController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorOffset));

    if (!undoRedoProvider.canRedo()) {
      undoRedoProvider.currentTyped.value = null;
      undoRedoProvider.currentCursorPosition = null;
    }

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
    detailProvider.setDetailCountNotify =
    await TextFieldLogic.countAllAsync(detailProvider.getDetail);
  }
}
