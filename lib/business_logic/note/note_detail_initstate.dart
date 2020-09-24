import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../data/deep.dart';
import '../../utility/extension.dart';
import 'provider/note_detail_provider.dart';
import 'provider/undo_redo_provider.dart';

void init({
  @required Note note,
  @required UndoRedoProvider undoRedoProvider,
  @required NoteDetailProvider detailProvider,
  @required TextEditingController detailController,
  @required FocusNode detailFocus,
}) {
  detailProvider.setNote = note;
  final detail = (detailProvider.getNote?.detail) ?? '';
  undoRedoProvider.initialDetail = detail;
  detailProvider.setDetail = detail;
  detailProvider.setTempDetail = detail;

  detailController.text = detail;

  if (detailProvider.getNote.isNull) {
    Future.delayed(const Duration(milliseconds: 400), () {
      detailFocus.requestFocus();

      undoRedoProvider.tempInitCursor = detailController.selection.baseOffset;
    });
  }

  KeyboardVisibility.onChange.listen((visible) {
    if (visible == false) {
      if (detailFocus.hasFocus) {
        detailFocus.unfocus();
      }
    }
  });
}
