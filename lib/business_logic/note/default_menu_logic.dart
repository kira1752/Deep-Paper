import 'package:deep_paper/UI/note/widgets/dialog/note_dialog.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:flutter/foundation.dart';

class DefaultMenuLogic {
  DefaultMenuLogic._();

  static void menuFolderSelected(
      {@required NoteDrawerProvider drawerProvider,
      @required int choice}) async {
    switch (choice) {
      case 0:
        await DeepDialog.openRenameFolderDialog(drawerProvider: drawerProvider);
        break;
      case 1:
        await DeepDialog.openDeleteFolderDialog(drawerProvider: drawerProvider);
        break;
      default:
    }
  }
}
