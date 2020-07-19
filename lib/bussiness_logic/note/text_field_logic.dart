import 'package:deep_paper/bussiness_logic/note/provider/note_detail_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/undo_redo_provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TextFieldLogic {
  TextFieldLogic._();

  static void detail(
      {@required String value,
      @required NoteDetailProvider detailProvider,
      @required UndoRedoProvider undoRedoProvider,
      @required TextEditingController controller}) {
    final firstOffset = value.isNullEmptyOrWhitespace
        ? controller.selection.extentOffset
        : controller.selection.extentOffset - 1;
    final secondOffset = controller.selection.extentOffset;
    detailProvider.setDetail = value;

    // check if "Undo Redo" can redo
    // if the result is true, clear all stored value inside "Redo queue"
    //
    // this used for case when user doing undo, then continue typing their text,
    // omitting user previous changes before doing undo
    // replacing them with text typed by user after doing undo
    if (undoRedoProvider.canRedo()) {
      undoRedoProvider.clearRedo();
    }

    // Turn on Undo Redo
    if (detailProvider.isTextTyped == false) {
      detailProvider.setTextState = true;
    }

    if (!undoRedoProvider.canUndo() && !undoRedoProvider.canRedo()) {
      undoRedoProvider.initialCursorPosition =
          undoRedoProvider.tempInitialCursorPosition;
    }

    // Check Detail text direction
    detailProvider.checkDetailDirection = detailProvider.getDetail;

    // Turn on Undo function when textField typed for the first time
    // and not only contains whitespace
    if (undoRedoProvider.canUndo() == false) {
      undoRedoProvider.setCanUndo = true;
    }

    /// Check for Latin characters
    if (!value.contains(RegExp(
        r"/[^\u0000-\u024F\u1E00-\u1EFF\u2C60-\u2C7F\uA720-\uA7FF]/g"))) {
      if (value.substring(firstOffset, secondOffset) == " ") {
        if (undoRedoProvider.space == false &&
            !undoRedoProvider.currentTyped.isNullEmptyOrWhitespace) {
          undoRedoProvider.addUndo();
          undoRedoProvider.currentTyped = value;
          undoRedoProvider.currentCursorPosition =
              controller.selection.extentOffset;
          undoRedoProvider.setContainSpace = true;
        } else {
          undoRedoProvider.setContainSpace = true;
          undoRedoProvider.currentTyped = value;
          undoRedoProvider.currentCursorPosition =
              controller.selection.extentOffset;
        }
      } else {
        undoRedoProvider.setContainSpace = false;
        undoRedoProvider.currentTyped = value;
        undoRedoProvider.currentCursorPosition =
            controller.selection.extentOffset;
      }
    } else {
      // this is for language like chinese, japanese, etc that rarely use whitespace
      if (undoRedoProvider.count == 4 && !value.isNullEmptyOrWhitespace) {
        // if user already typed 4 characters
        // add previous value after user typing 4 characters into "Undo queue"
        // then, set current typed value to current text typed by user and reset "count" value
        undoRedoProvider.addUndo();
        undoRedoProvider.currentTyped = value;
        undoRedoProvider.currentCursorPosition =
            controller.selection.extentOffset;
        undoRedoProvider.count = 1;
      } else {
        // else set current typed value to current text typed by user
        // without adding text typed by user into "Undo queue"
        // and increment "count" value by one
        undoRedoProvider.count = undoRedoProvider.count + 1;
        undoRedoProvider.currentTyped = value;
        undoRedoProvider.currentCursorPosition =
            controller.selection.extentOffset;
      }
    }
  }
}
