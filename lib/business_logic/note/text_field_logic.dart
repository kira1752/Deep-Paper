import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'note_debounce.dart';
import 'provider/note_detail_provider.dart';
import 'provider/undo_history_provider.dart';
import 'provider/undo_state_provider.dart';

Future<void> detail(
    {@required String value,
    @required NoteDetailProvider detailProvider,
    @required UndoHistoryProvider undoHistory,
    @required UndoStateProvider undoState,
    @required NoteDetailDebounce debounceProvider,
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
  if (undoState.canRedo) {
    undoHistory.clearRedo();
    undoState.toggleRedo();
  }

// Turn on Undo Redo
  if (detailProvider.isTextTyped == false) {
    detailProvider.isTextTyped = true;
  }

  if (undoHistory.isUndoEmpty() && undoHistory.isRedoEmpty()) {
    undoHistory.initialCursorPosition = undoHistory.tempInitCursor;
  }

// Check Detail text direction
  detailProvider.checkDetailDirection = detailProvider.getDetail;

// Turn on Undo function when textField typed for the first time
// and not only contains whitespace
  if (!undoState.canUndo) {
    undoState.toggleUndo();
  }

  undoHistory.currentTyped = value;
  undoHistory.currentCursorPosition = controller.selection.baseOffset;

  // Save undo state in 1 second
  debounceProvider.run(undoHistory);
}

int countAll(String text) {
  return text.replaceAll(RegExp(r'\s+\b|\b\s|\s|\b'), '').length;
}

String loadDate(DateTime time) {
  if (time == null) {
    return intl.DateFormat.jm('en_US').format(DateTime.now());
  } else {
    final now =
    DateTime(DateTime
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
        ? intl.DateFormat.jm('en_US').format(time)
        : (now
        .difference(noteDate)
        .inDays == 1
        ? "Yesterday, ${intl.DateFormat.jm("en_US").format(time)}"
        : (now
        .difference(noteDate)
        .inDays > 1 && now.year - time.year == 0
        ? intl.DateFormat.MMMd('en_US').add_jm().format(time)
        : intl.DateFormat.yMMMd('en_US').add_jm().format(time)));

    return date;
  }
}

Future<int> countAllAsync(String text) {
  final result = compute(countAll, text);
  return result;
}

Future<String> loadDateAsync(DateTime time) {
  final result = compute(loadDate, time);
  return result;
}
