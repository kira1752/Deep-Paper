import 'package:deep_paper/note/provider/note_detail_provider.dart';
import 'package:deep_paper/note/provider/undo_redo_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class TextFieldLogic {
  static void title(
      {@required String value,
      @required NoteDetailProvider detailProvider,
      @required UndoRedoProvider undoRedoProvider}) {
    detailProvider.setTitle = value;

    // Turn on Undo Redo
    if (detailProvider.isTextTyped == false) {
      detailProvider.setTextState = true;
    }

    // Check Title text direction
    detailProvider.checkTitleDirection = detailProvider.getTitle;

    if (undoRedoProvider.getCurrentFocus.isEmpty) {
      // If Title text field is chosen for the first time,
      // set current focus to "title"
      debugPrintSynchronously("this run");
      undoRedoProvider.setCurrentFocus = "title";
    } else if (undoRedoProvider.getCurrentFocus == "detail" &&
        undoRedoProvider.getFieldChanged == false) {
      // else if Title textfield chosen for the first time after typing in Detail Textfield
      // set current focus to "endOfDetail" to mark the end of Detail TextField editing
      // then, add previous edit in Detail Textfield into "Undo queue"
      // set current focus to "initialTitle"
      // add the initial state of title textfield into "Undo queue"
      // then, set field changed value to true
      undoRedoProvider.setCurrentFocus = "endOfDetail";
      undoRedoProvider.addUndo();
      undoRedoProvider.setCurrentFocus = "initialTitle";
      undoRedoProvider.addUndoForInitialTitle();
      undoRedoProvider.setFieldChanged = true;
    } else if (undoRedoProvider.getCurrentFocus == "initialTitle" &&
        undoRedoProvider.getFieldChanged == false) {
      // this is for case when Title textfield chosen for the first time after typing in Detail Textfield
      // then after that user do undo until field changed turns to false
      // which cause Title textfield fall to first time chosen state
      // so this code simply add the initial state of Title textfield into "Undo queue" again
      // then, set field changed value to true again

      undoRedoProvider.addUndoForInitialTitle();
      undoRedoProvider.setFieldChanged = true;
    } else {
      // else if Title textfield chosen after typing in Detail Textfield
      // add previous edit in Detail Textfield into "Undo queue"
      // then, set current focus to "title"
      // but if the current focus not from "detail" (like "initialTitle")
      // then, simply set current focus to "title"

      if (undoRedoProvider.getCurrentFocus == "detail") {
        undoRedoProvider.setCurrentFocus = "endOfDetail";
        undoRedoProvider.addUndo();
      }
      undoRedoProvider.setCurrentFocus = "title";
    }

    // Turn on Undo function when textfield typed for the first time
    // and not only contains whitespace
    if (undoRedoProvider.canUndo() == false && !value.isNullEmptyOrWhitespace) {
      debugPrintSynchronously('CAN UNDO');
      undoRedoProvider.setCanUndo = true;
    }

    /// Check for Latin characters
    if (value.contains(RegExp(r"[a-zA-Z\u00C0-\u024F\u1E00-\u1EFF]"))) {
      if (value.endsWith(" ") && !value.isNullEmptyOrWhitespace) {
        // if text typed by user ends with whitespace
        // add previous value before whitespace into "Undo queue"
        // then, set current typed value to current text typed by user
        if (!undoRedoProvider.getInitialTitle.isNullEmptyOrWhitespace &&
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

    if (undoRedoProvider.getCurrentFocus.isEmpty) {
      // If Detail text field is chosen for the first time,
      // set current focus to "detail"
      debugPrintSynchronously("this run");
      undoRedoProvider.setCurrentFocus = "detail";
    } else if (undoRedoProvider.getCurrentFocus == "title" &&
        undoRedoProvider.getFieldChanged == false) {
      // else if Detail textfield chosen for the first time after typing in Title Textfield
      // set current focus to "endOfTitle" to mark the end of Title TextField editing
      // then, add previous edit in Title Textfield into "Undo queue"
      // set current focus to "initialDetail"
      // add the initial state of Detail textfield into "Undo queue"
      // then, set field changed value to true
      undoRedoProvider.setCurrentFocus = "endOfTitle";
      undoRedoProvider.addUndo();
      undoRedoProvider.setCurrentFocus = "initialDetail";
      undoRedoProvider.addUndoForInitialDetail();
      undoRedoProvider.setFieldChanged = true;
    } else if (undoRedoProvider.getCurrentFocus == "initialDetail" &&
        undoRedoProvider.getFieldChanged == false) {
      // this is for case when Detail textfield chosen for the first time after typing in Title Textfield
      // then after that user do undo until field changed turns to false
      // which cause Detail textfield fall to first time chosen state
      // so this code simply try to set current focus to "initialDetail" again
      // and add the initial state of Detail textfield into "Undo queue" again
      // then, set field changed value to true again
      undoRedoProvider.addUndoForInitialDetail();
      undoRedoProvider.setFieldChanged = true;
    } else {
      // else if Detail textfield chosen after typing in Title Textfield
      // add previous edit in Title Textfield into "Undo queue"
      // then, set current focus to "detail"
      // but if the current focus not from "title" (like "initialDetail")
      // then, simply set current focus to "detail"

      if (undoRedoProvider.getCurrentFocus == "title") {
        undoRedoProvider.setCurrentFocus = "endOfTitle";
        undoRedoProvider.addUndo();
      }

      undoRedoProvider.setCurrentFocus = "detail";
    }

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
