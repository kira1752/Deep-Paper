import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../UI/note/widgets/dialog/move_to_folder.dart';
import '../../UI/widgets/deep_toast.dart';
import '../../data/deep.dart';
import 'note_creation.dart';
import 'provider/deep_bottom_provider.dart';
import 'provider/fab_provider.dart';
import 'provider/note_drawer_provider.dart';
import 'provider/selection_provider.dart';
import 'trash_management.dart';

class SelectionMenuLogic {
  SelectionMenuLogic._();

  static void menuTrashSelected(
      {@required DeepBottomProvider deepBottomProvider,
      @required SelectionProvider selectionProvider,
      @required FABProvider fabProvider,
      @required int choice}) {
    switch (choice) {
      case 0:
        TrashManagement.restoreBatch(selectionProvider: selectionProvider);

        DeepToast.showToast(description: 'Note restored successfully');

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;

      case 1:
        TrashManagement.deleteBatch(selectionProvider: selectionProvider);

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

  static Future<void> menuSelectionSelected({@required int choice,
    @required DeepBottomProvider deepBottomProvider,
    @required SelectionProvider selectionProvider,
    @required FABProvider fabProvider,
    @required NoteDrawerProvider drawerProvider}) async {
    final database = Provider.of<DeepPaperDatabase>(Get.context, listen: false);

    switch (choice) {
      case 0:
        await NoteCreation.moveToTrashBatch(
            selectionProvider: selectionProvider);

        await DeepToast.showToast(description: 'Note moved to Trash Bin');

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;
      case 1:
        final currentFolder = drawerProvider.getFolder;

        final drawerIndex = drawerProvider.getIndexDrawerItem;

        await MoveToFolder.openMoveToDialog(
            currentFolder: currentFolder,
            drawerIndex: drawerIndex,
            selectionProvider: selectionProvider,
            deepBottomProvider: deepBottomProvider,
            fabProvider: fabProvider,
            database: database);
        break;
      case 2:
        await NoteCreation.copySelectedNotes(
            selectionProvider: selectionProvider);

        await DeepToast.showToast(description: 'Note copied successfully');

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;
      default:
    }
  }
}
