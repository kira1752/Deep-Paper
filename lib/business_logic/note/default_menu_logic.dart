import 'package:deep_paper/UI/note/widgets/dialog/note_dialog.dart';
import 'package:flutter/material.dart';

class DefaultMenuLogic {
  DefaultMenuLogic._();

  static void menuFolderSelected(
      {@required BuildContext context, @required int choice}) async {
    switch (choice) {
      case 0:
        await DeepDialog.openRenameFolderDialog(context: context);
        break;
      case 1:
        await DeepDialog.openDeleteFolderDialog(context: context);
        break;
      default:
    }
  }
}
