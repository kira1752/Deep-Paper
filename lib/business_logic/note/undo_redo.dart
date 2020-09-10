import 'package:deep_paper/business_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/business_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/business_logic/note/text_field_logic.dart';
import 'package:flutter/widgets.dart';

class UndoRedoBusinessLogic {
  UndoRedoBusinessLogic._();

  static Future<void> undo({
    @required UndoRedoProvider undoRedoProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController,
  }) async {
    final cursorOffset = undoRedoProvider.popUndoCursor();

    detailController.text = undoRedoProvider.popUndoValue();
    detailController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset, affinity: TextAffinity.downstream));

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
    detailController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset, affinity: TextAffinity.upstream));

    if (!undoRedoProvider.canRedo()) {
      undoRedoProvider.currentTyped.value = null;
      undoRedoProvider.currentCursorPosition.value = null;
    }

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
    detailProvider.setDetailCountNotify =
        await TextFieldLogic.countAllAsync(detailProvider.getDetail);
  }
}
