import 'package:flutter/widgets.dart';

import 'provider/note_detail_provider.dart';
import 'provider/undo_redo_provider.dart';
import 'text_field_logic.dart' as text_field_logic;

Future<void> undo({
  @required UndoRedoProvider undoRedoProvider,
  @required NoteDetailProvider detailProvider,
  @required TextEditingController detailController,
}) async {
  final undoModel = undoRedoProvider.popUndoValue();

  detailController.text = undoModel.currentTyped;
  detailController.selection = TextSelection.fromPosition(
      TextPosition(offset: undoModel.currentCursorPosition));

  detailProvider.setDetail = detailController.text;
  detailProvider.checkDetailDirection = detailController.text;
  detailProvider.setDetailCountNotify =
      await text_field_logic.countAllAsync(detailProvider.getDetail);
}

Future<void> redo(
    {@required UndoRedoProvider undoRedoProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController}) async {
  final undoModel = undoRedoProvider.popRedoValue();

  detailController.text = undoModel.currentTyped;
  detailController.selection = TextSelection.fromPosition(
      TextPosition(offset: undoModel.currentCursorPosition));

  if (!undoRedoProvider.canRedo()) {
    undoRedoProvider.currentTyped = null;
    undoRedoProvider.currentCursorPosition = null;
  }

  detailProvider.setDetail = detailController.text;
  detailProvider.checkDetailDirection = detailController.text;
  detailProvider.setDetailCountNotify =
  await text_field_logic.countAllAsync(detailProvider.getDetail);
}
