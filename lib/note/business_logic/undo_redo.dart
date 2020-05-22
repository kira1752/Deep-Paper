import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UndoRedo {
  static void undo(
      {@required BuildContext context,
      @required TextEditingController titleController,
      @required TextEditingController detailController}) {
    final provider = Provider.of<UndoRedoProvider>(context, listen: false);
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    if (provider.getUndoFocus() == "") {
      if (provider.lastFocus() == "title") {
        titleController.text = provider.getUndoValue();
        titleController.selection = TextSelection(
            baseOffset: titleController.text.length,
            extentOffset: titleController.text.length);

        detailProvider.setTitle = titleController.text;
        detailProvider.checkTitleDirection = titleController.text;
      } else {
        detailController.text = provider.getUndoValue();
        detailController.selection = TextSelection(
            baseOffset: detailController.text.length,
            extentOffset: detailController.text.length);

        detailProvider.setDetail = detailController.text;
        detailProvider.checkDetailDirection = detailController.text;
      }
    } else if (provider.getUndoFocus() == "title") {
      titleController.text = provider.getUndoValue();
      titleController.selection = TextSelection(
          baseOffset: titleController.text.length,
          extentOffset: titleController.text.length);

      detailProvider.setTitle = titleController.text;
      detailProvider.checkTitleDirection = titleController.text;
    } else {
      detailController.text = provider.getUndoValue();
      detailController.selection = TextSelection(
          baseOffset: detailController.text.length,
          extentOffset: detailController.text.length);

      detailProvider.setDetail = detailController.text;
      detailProvider.checkDetailDirection = detailController.text;
    }
  }

  static void redo(
      {@required BuildContext context,
      @required TextEditingController titleController,
      @required TextEditingController detailController}) {
    final provider = Provider.of<UndoRedoProvider>(context, listen: false);
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    if (provider.getRedoFocus() == "title") {
      titleController.text = provider.getRedoValue();
      titleController.selection = TextSelection(
          baseOffset: titleController.text.length,
          extentOffset: titleController.text.length);

      detailProvider.setTitle = titleController.text;
      detailProvider.checkTitleDirection = titleController.text;
    } else {
      detailController.text = provider.getRedoValue();
      detailController.selection = TextSelection(
          baseOffset: detailController.text.length,
          extentOffset: detailController.text.length);

      detailProvider.setDetail = detailController.text;
      detailProvider.checkDetailDirection = detailController.text;
    }
  }
}
