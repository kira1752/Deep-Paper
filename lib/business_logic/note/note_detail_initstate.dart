import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../utility/extension.dart';
import '../provider/note/note_detail_provider.dart';
import '../provider/note/undo_history_provider.dart';

void noteDetailInit({
  @required UndoHistoryProvider undoHistoryProvider,
  @required NoteDetailProvider detailProvider,
  @required TextEditingController detailController,
  @required FocusNode detailFocus,
}) {
  final detail = (detailProvider.getNote?.detail) ?? '';
  undoHistoryProvider.initialDetail = detail;

  detailProvider.setDetail = detail;
  detailProvider.initialDetailDirection = detail;
  detailProvider.setTempDetail = detail;

  detailController.text = detail;

  if (detailProvider.getNote.isNull) {
    Future.delayed(const Duration(milliseconds: 400), () {
      detailFocus.requestFocus();

      undoHistoryProvider.tempInitCursor =
          detailController.selection.baseOffset;
    });
  }

  KeyboardVisibilityController().onChange.listen((visible) {
    if (visible == false) {
      if (detailFocus.hasFocus) {
        detailFocus.unfocus();
      }
    }
  });
}
