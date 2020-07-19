import 'package:deep_paper/bussiness_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UndoRedo {
  UndoRedo._();

  static void undo({
    @required BuildContext context,
    @required TextEditingController detailController,
  }) {
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    final cursorOffset = undoRedoProvider.getUndoCursor();

    detailController.text = undoRedoProvider.getUndoValue();
    detailController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorOffset));

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
  }

  static void redo(
      {@required BuildContext context,
      @required TextEditingController detailController}) {
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);
    final cursorOffset = undoRedoProvider.getRedoCursor();

    detailController.text = undoRedoProvider.getRedoValue();
    detailController.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorOffset));

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
  }
}
