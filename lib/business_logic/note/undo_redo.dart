import 'package:flutter/widgets.dart';

import 'provider/note_detail_provider.dart';
import 'provider/undo_redo_provider.dart';
import 'text_field_logic.dart' as text_field_logic;

Future<void> undo({
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
      await text_field_logic.countAllAsync(detailProvider.getDetail);
}

Future<void> redo(
    {@required UndoRedoProvider undoRedoProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController}) async {
  final cursorOffset = undoRedoProvider.popRedoCursor();

  detailController.text = undoRedoProvider.popRedoValue();
  detailController.selection =
      TextSelection.fromPosition(TextPosition(offset: cursorOffset));

  if (!undoRedoProvider.canRedo()) {
    undoRedoProvider.currentTyped = null;
    undoRedoProvider.currentCursorPosition = null;
  }

  detailProvider.setDetail = detailController.text;
  detailProvider.checkDetailDirection = detailController.text;
  detailProvider.setDetailCountNotify =
      await text_field_logic.countAllAsync(detailProvider.getDetail);
}
