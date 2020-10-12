import 'package:flutter/widgets.dart';

import '../../UI/note/widgets/dialog/move_to_folder.dart' as move_to_folder;
import '../../UI/widgets/deep_snack_bar.dart';
import '../../data/deep.dart';
import '../../resource/icon_resource.dart';
import 'note_creation.dart' as note_creation;
import 'provider/deep_bottom_provider.dart';
import 'provider/fab_provider.dart';
import 'provider/note_drawer_provider.dart';
import 'provider/selection_provider.dart';
import 'trash_management.dart' as trash_management;

void menuTrashSelected(
    {@required BuildContext context,
    @required DeepPaperDatabase database,
    @required BottomNavBarProvider deepBottomProvider,
    @required SelectionProvider selectionProvider,
    @required FABProvider fabProvider,
    @required int choice}) {
  switch (choice) {
    case 0:
      trash_management.restoreBatch(
          database: database, selectionProvider: selectionProvider);

      showSnack(
          context: context,
          icon: successful(context: context),
          description: 'Note restored successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;

    case 1:
      trash_management.deleteBatch(
          database: database, selectionProvider: selectionProvider);

      showSnack(
          context: context,
          icon: successful(context: context),
          description: 'Note deleted successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;

    default:
      break;
  }
}

Future<void> menuSelectionSelected(
    {@required BuildContext context,
    @required int choice,
    @required DeepPaperDatabase database,
    @required BottomNavBarProvider deepBottomProvider,
    @required SelectionProvider selectionProvider,
    @required FABProvider fabProvider,
    @required NoteDrawerProvider drawerProvider}) async {
  switch (choice) {
    case 0:
      await note_creation.moveToTrashBatch(
          database: database, selectionProvider: selectionProvider);

      showSnack(
          context: context,
          icon: info(context: context),
          description: 'Note moved to Trash Bin');

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

      showSnack(
          context: context,
          icon: successful(context: context),
          description: 'Note copied successfully');

      deepBottomProvider.setSelection = false;
      selectionProvider.setSelection = false;
      fabProvider.setScrollDown = false;
      selectionProvider.getSelected.clear();

      break;
    default:
  }
}
