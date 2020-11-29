import 'package:flutter/widgets.dart';

import '../provider/note/note_detail_provider.dart';
import '../provider/note/undo_history_provider.dart';
import '../provider/note/undo_state_provider.dart';
import 'text_field_logic.dart' as text_field_logic;

Future<void> undo({
  @required UndoHistoryProvider undoHistoryProvider,
  @required UndoStateProvider undoStateProvider,
  @required NoteDetailProvider detailProvider,
  @required TextEditingController detailController,
}) async {
  final undoModel = undoHistoryProvider.undo();

  detailController.text = undoModel.currentTyped;
  detailController.selection = TextSelection.fromPosition(
      TextPosition(offset: undoModel.currentCursorPosition));

  detailProvider.setDetail = detailController.text;
  detailProvider.checkDetailDirection = detailController.text;
  detailProvider.setDetailCountNotify =
      await text_field_logic.countAllAsync(detailProvider.getDetail);
}

Future<void> redo(
    {@required UndoHistoryProvider undoHistoryProvider,
    @required UndoStateProvider undoStateProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController}) async {
  final undoModel = undoHistoryProvider.redo();

  detailController.text = undoModel.currentTyped;
  detailController.selection = TextSelection.fromPosition(
      TextPosition(offset: undoModel.currentCursorPosition));

  if (!undoHistoryProvider.isRedoEmpty()) {
    undoHistoryProvider.currentTyped = null;
    undoHistoryProvider.currentCursorPosition = null;
  }

  detailProvider.setDetail = detailController.text;
  detailProvider.checkDetailDirection = detailController.text;
  detailProvider.setDetailCountNotify =
      await text_field_logic.countAllAsync(detailProvider.getDetail);
}
