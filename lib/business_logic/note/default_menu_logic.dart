import 'package:flutter/foundation.dart';

import '../../UI/note/widgets/dialog/note_dialog.dart';
import 'provider/note_drawer_provider.dart';

class DefaultMenuLogic {
  DefaultMenuLogic._();

  static Future<void> menuFolderSelected(
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
