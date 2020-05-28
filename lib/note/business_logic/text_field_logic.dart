import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class TextFieldLogic {
  static void detail(
      {@required String value,
      @required NoteDetailProvider detailProvider,
      @required UndoRedoProvider undoRedoProvider}) {
    detailProvider.setDetail = value;

    // Turn on Undo Redo
    if (detailProvider.isTextTyped == false) {
      detailProvider.setTextState = true;
    }

    // Check Detail text direction
    detailProvider.checkDetailDirection = detailProvider.getDetail;

    // Turn on Undo function when textfield typed for the first time
    // and not only contains whitespace
    if (undoRedoProvider.canUndo() == false && !value.isNullEmptyOrWhitespace) {
      undoRedoProvider.setCanUndo = true;
    }

    /// Check for Latin characters
    if (value.contains(RegExp(r"[a-zA-Z\u00C0-\u024F\u1E00-\u1EFF]"))) {
      if (value.endsWith(" ") && !value.isNullEmptyOrWhitespace) {
        // if text typed by user ends with whitespace
        // add previous value before whitespace into "Undo queue"
        // then, set current typed value to current text typed by user
        if (!undoRedoProvider.getInitialDetail.isNullEmptyOrWhitespace &&
            undoRedoProvider.getCurrentTyped.isNullEmptyOrWhitespace) {
          undoRedoProvider.setCurrentTyped = value;
        } else {
          undoRedoProvider.addUndo();
          undoRedoProvider.setCurrentTyped = value;
        }
      } else {
        // else set current typed value to current text typed by user
        // without adding text typed by user into "Undo queue"
        undoRedoProvider.setCurrentTyped = value;
      }
    } else {
      // this is for language like chinese, japanese, etc that rarely use whitespace
      if (undoRedoProvider.getCount == 4 && !value.isNullEmptyOrWhitespace) {
        // if user already typed 4 characters
        // add previous value after user typing 4 characters into "Undo queue"
        // then, set current typed value to current text typed by user and reset "count" value
        undoRedoProvider.addUndo();
        undoRedoProvider.setCurrentTyped = value;
        undoRedoProvider.setCount = 1;
      } else {
        // else set current typed value to current text typed by user
        // without adding text typed by user into "Undo queue"
        // and increment "count" value by one
        undoRedoProvider.setCount = undoRedoProvider.getCount + 1;
        undoRedoProvider.setCurrentTyped = value;
      }
    }

    // check if "Undo Redo" can redo
    // if the result is true, clear all stored value inside "Redo queue"
    //
    // this used for case when user doing undo, then continue typing their text,
    // omiting user previous changes before doing undo
    // replacing them with text typed by user after doing undo
    if (undoRedoProvider.canRedo()) {
      undoRedoProvider.clearRedo();
    }
  }
}
