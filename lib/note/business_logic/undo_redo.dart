import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UndoRedo {
  static void undo(
      {@required BuildContext context,
      @required TextEditingController titleController,
      @required TextEditingController detailController,
      @required FocusNode titleFocus,
      @required FocusNode detailFocus}) {
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);

    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final undoFocus = undoRedoProvider.getUndoFocus();

    if (undoFocus == "") {
      if (undoRedoProvider.lastFocus() == "title") {
        final undoValue = undoRedoProvider.getUndoValue();

        if (!titleFocus.hasFocus) {
          titleFocus.requestFocus();
        }

        if (undoValue == "") {
          titleController.text = undoRedoProvider.getInitialTitle;
          titleController.selection = TextSelection(
              baseOffset: titleController.text.length,
              extentOffset: titleController.text.length);

          detailProvider.setTitle = titleController.text;
          detailProvider.checkTitleDirection = titleController.text;
        } else {
          titleController.text = undoRedoProvider.getUndoValue();
          titleController.selection = TextSelection(
              baseOffset: titleController.text.length,
              extentOffset: titleController.text.length);

          detailProvider.setTitle = titleController.text;
          detailProvider.checkTitleDirection = titleController.text;
        }
      } else {
        final undoValue = undoRedoProvider.getUndoValue();

        if (!detailFocus.hasFocus) {
          detailFocus.requestFocus();
        }

        if (undoValue == "") {
          detailController.text = undoRedoProvider.getInitialDetail;
          detailController.selection = TextSelection(
              baseOffset: detailController.text.length,
              extentOffset: detailController.text.length);

          detailProvider.setDetail = detailController.text;
          detailProvider.checkDetailDirection = detailController.text;
        } else {
          detailController.text = undoRedoProvider.getUndoValue();
          detailController.selection = TextSelection(
              baseOffset: detailController.text.length,
              extentOffset: detailController.text.length);

          detailProvider.setDetail = detailController.text;
          detailProvider.checkDetailDirection = detailController.text;
        }
      }
    } else if (undoFocus == "title" || undoFocus == "initialTitle") {
      if (undoFocus == "initialTitle") {
        undoRedoProvider.setFieldChanged = false;
      }

      if (!titleFocus.hasFocus) {
        titleFocus.requestFocus();
      }

      titleController.text = undoRedoProvider.getUndoValue();
      titleController.selection = TextSelection(
          baseOffset: titleController.text.length,
          extentOffset: titleController.text.length);

      detailProvider.setTitle = titleController.text;
      detailProvider.checkTitleDirection = titleController.text;
    } else if (undoFocus == "detail" || undoFocus == "initialDetail") {
      if (undoFocus == "initialDetail") {
        undoRedoProvider.setFieldChanged = false;
      }

      if (!detailFocus.hasFocus) {
        detailFocus.requestFocus();
      }

      detailController.text = undoRedoProvider.getUndoValue();
      detailController.selection = TextSelection(
          baseOffset: detailController.text.length,
          extentOffset: detailController.text.length);

      detailProvider.setDetail = detailController.text;
      detailProvider.checkDetailDirection = detailController.text;
    } else {
      undoRedoProvider.skipCurrentUndo();
      undo(
          context: context,
          titleController: titleController,
          detailController: detailController,
          titleFocus: titleFocus,
          detailFocus: detailFocus);
    }
  }

  static void redo(
      {@required BuildContext context,
      @required TextEditingController titleController,
      @required TextEditingController detailController,
      @required FocusNode titleFocus,
      @required FocusNode detailFocus}) {
    final undoRedoProvider =
        Provider.of<UndoRedoProvider>(context, listen: false);
    final detailProvider =
        Provider.of<NoteDetailProvider>(context, listen: false);

    final redoFocus = undoRedoProvider.getRedoFocus();

    if (redoFocus == "title" || redoFocus == "endOfTitle") {
      if (!titleFocus.hasFocus) {
        titleFocus.requestFocus();
      }

      titleController.text = undoRedoProvider.getRedoValue();
      titleController.selection = TextSelection(
          baseOffset: titleController.text.length,
          extentOffset: titleController.text.length);

      detailProvider.setTitle = titleController.text;
      detailProvider.checkTitleDirection = titleController.text;
    } else if (redoFocus == "detail" || redoFocus == "endOfDetail") {
      if (!detailFocus.hasFocus) {
        detailFocus.requestFocus();
      }

      detailController.text = undoRedoProvider.getRedoValue();
      detailController.selection = TextSelection(
          baseOffset: detailController.text.length,
          extentOffset: detailController.text.length);

      detailProvider.setDetail = detailController.text;
      detailProvider.checkDetailDirection = detailController.text;
    } else {
      if (redoFocus == "initialTitle" || redoFocus == "initialDetail") {
        undoRedoProvider.setFieldChanged = true;
      }

      undoRedoProvider.skipCurrentRedo();
      redo(
          context: context,
          titleController: titleController,
          detailController: detailController,
          titleFocus: titleFocus,
          detailFocus: detailFocus);
    }
  }
}
