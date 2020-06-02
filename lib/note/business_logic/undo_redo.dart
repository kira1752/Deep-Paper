import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UndoRedo {
  static void undo({
    @required BuildContext context,
    @required TextEditingController detailController,
  }) {
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    detailController.text = undoRedoProvider.getUndoValue();
    detailController.selection = TextSelection(
        baseOffset: detailController.text.length,
        extentOffset: detailController.text.length);

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

    detailController.text = undoRedoProvider.getRedoValue();
    detailController.selection = TextSelection(
        baseOffset: detailController.text.length,
        extentOffset: detailController.text.length);

    detailProvider.setDetail = detailController.text;
    detailProvider.checkDetailDirection = detailController.text;
  }
}
