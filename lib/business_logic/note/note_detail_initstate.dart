import 'package:deep_paper/resource/string_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../data/deep.dart';
import '../../utility/extension.dart';
import 'provider/note_detail_provider.dart';
import 'provider/undo_history_provider.dart';

void init(
    {@required Note note,
    @required UndoHistoryProvider undoHistoryProvider,
    @required NoteDetailProvider detailProvider,
    @required TextEditingController detailController,
    @required FocusNode detailFocus,
    @required String folderName,
    @required int folderID}) {
  detailProvider.setNote = note;
  final detail = (detailProvider.getNote?.detail) ?? '';
  undoHistoryProvider.initialDetail = detail;
  detailProvider.setDetail = detail;
  detailProvider.setTempDetail = detail;
  detailProvider.folderName = folderName ?? StringResource.mainFolder;
  detailProvider.folderID = folderID ?? 0;

  detailController.text = detail;

  if (detailProvider.getNote.isNull) {
    Future.delayed(const Duration(milliseconds: 400), () {
      detailFocus.requestFocus();

      undoHistoryProvider.tempInitCursor =
          detailController.selection.baseOffset;
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
