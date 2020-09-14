import 'package:flutter/widgets.dart';

import '../../UI/note/widgets/dialog/note_dialog.dart' as note_dialog;
import 'provider/note_drawer_provider.dart';

Future<void> menuFolderSelected(
    {@required BuildContext context,
    @required NoteDrawerProvider drawerProvider,
    @required int choice}) async {
  switch (choice) {
    case 0:
      await note_dialog.openRenameFolderDialog(
          context: context, drawerProvider: drawerProvider);
      break;
    case 1:
      await note_dialog.openDeleteFolderDialog(
          context: context, drawerProvider: drawerProvider);
      break;
    default:
  }
}
