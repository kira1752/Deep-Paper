import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'provider/note_detail_provider.dart';
import 'provider/undo_redo_provider.dart';

class TextFieldLogic {
  TextFieldLogic._();

  static Future<void> detail(
      {@required String value,
      @required NoteDetailProvider detailProvider,
      @required UndoRedoProvider undoRedoProvider,
      @required TextEditingController controller}) async {
    detailProvider.setDetail = value;
    detailProvider.setDetailCountNotify =
        await countAllAsync(detailProvider.getDetail);

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

    undoRedoProvider.currentTyped.value = value;
    undoRedoProvider.currentCursorPosition = controller.selection.baseOffset;
  }

  static int countAll(String text) {
    return text.replaceAll(RegExp(r'\s+\b|\b\s|\s|\b'), '').length;
  }

  static String loadDate(DateTime time) {
    if (time == null) {
      return DateFormat.jm('en_US').format(DateTime.now());
    } else {
      final now = DateTime(
          DateTime
              .now()
              .year, DateTime
          .now()
          .month, DateTime
          .now()
          .day);
      final noteDate = DateTime(time.year, time.month, time.day);

      final date = now
          .difference(noteDate)
          .inDays == 0
          ? DateFormat.jm('en_US').format(time)
          : (now
          .difference(noteDate)
          .inDays == 1
          ? "Yesterday, ${DateFormat.jm("en_US").format(time)}"
          : (now
          .difference(noteDate)
          .inDays > 1 &&
          now.year - time.year == 0
          ? DateFormat.MMMd('en_US').add_jm().format(time)
          : DateFormat.yMMMd('en_US').add_jm().format(time)));

      return date;
    }
  }

  static Future<int> countAllAsync(String text) {
    final result = compute(countAll, text);
    return result;
  }

  static Future<String> loadDateAsync(DateTime time) {
    final result = compute(loadDate, time);
    return result;
  }
}
