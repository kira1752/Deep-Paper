import 'package:deep_paper/UI/note/widgets/bottom_modal.dart';
import 'package:flutter/material.dart';

class DefaultMenuLogic {
  DefaultMenuLogic._();

  static void menuFolderSelected(
      {@required BuildContext context, @required int choice}) async {
    switch (choice) {
      case 0:
        await BottomModal.openRenameFolderDialog(context: context);
        break;
      case 1:
        await BottomModal.openDeleteFolderDialog(context: context);
        break;
      default:
    }
  }
}