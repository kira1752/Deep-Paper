import 'package:flutter/widgets.dart';

import '../../UI/note/widgets/dialog/move_to_folder.dart' as move_to_folder;
import '../../UI/widgets/deep_toast.dart';
import '../../data/deep.dart';
import 'note_creation.dart' as note_creation;
import 'provider/deep_bottom_provider.dart';
import 'provider/fab_provider.dart';
import 'provider/note_drawer_provider.dart';
import 'provider/selection_provider.dart';
import 'trash_management.dart' as trash_management;

void menuTrashSelected(
    {@required DeepPaperDatabase database,
    @required DeepBottomProvider deepBottomProvider,
    @required SelectionProvider selectionProvider,
    @required FABProvider fabProvider,
    @required int choice}) {
  switch (choice) {
    case 0:
      trash_management.restoreBatch(
          database: database, selectionProvider: selectionProvider);

      DeepToast.showToast(description: 'Note restored successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;

    case 1:
      trash_management.deleteBatch(
          database: database, selectionProvider: selectionProvider);

      DeepToast.showToast(description: 'Note deleted successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;

    default:
      break;
  }
}

Future<void> menuSelectionSelected({@required BuildContext context,
  @required int choice,
  @required DeepPaperDatabase database,
  @required DeepBottomProvider deepBottomProvider,
  @required SelectionProvider selectionProvider,
  @required FABProvider fabProvider,
  @required NoteDrawerProvider drawerProvider}) async {
  switch (choice) {
    case 0:
      await note_creation.moveToTrashBatch(
          database: database, selectionProvider: selectionProvider);

      await DeepToast.showToast(description: 'Note moved to Trash Bin');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;
    case 1:
      final currentFolder = drawerProvider.getFolder;

      final drawerIndex = drawerProvider.getIndexDrawerItem;

      await move_to_folder.openMoveToDialog(
          context: context,
          currentFolder: currentFolder,
          drawerIndex: drawerIndex,
          selectionProvider: selectionProvider,
          deepBottomProvider: deepBottomProvider,
          fabProvider: fabProvider,
          database: database);
      break;
    case 2:
      await note_creation.copySelectedNotes(
          database: database, selectionProvider: selectionProvider);

      await DeepToast.showToast(description: 'Note copied successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;
    default:
  }
}
