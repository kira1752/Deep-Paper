import 'package:deep_paper/UI/note/widgets/move_to_folder.dart';
import 'package:deep_paper/UI/widgets/deep_toast.dart';
import 'package:deep_paper/business_logic/note/note_creation.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/business_logic/note/trash_management.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionMenuLogic {
  SelectionMenuLogic._();

  static void menuTrashSelected(
      {@required BuildContext context, @required int choice}) {
    final deepBottomProvider =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    switch (choice) {
      case 0:
        TrashManagement.restoreBatch(context: context);

        DeepToast.showToast(description: "Note restored successfully");

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;

      case 1:
        TrashManagement.deleteBatch(context: context);

        DeepToast.showToast(description: "Note deleted successfully");

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;

      default:
        break;
    }
  }

  static Future<void> menuSelectionSelected(
      {@required BuildContext context, @required int choice}) async {
    final deepBottomProvider =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final selectionProvider =
        Provider.of<SelectionProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    switch (choice) {
      case 0:
        NoteCreation.moveToTrashBatch(context: context);

        DeepToast.showToast(description: "Note moved to Trash Bin");

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;
      case 1:
        final currentFolder = drawerProvider.getFolder;

        final drawerIndex = drawerProvider.getIndexDrawerItem;

        MoveToFolder.openMoveToDialog(
            context: context,
            currentFolder: currentFolder,
            drawerIndex: drawerIndex,
            selectionProvider: selectionProvider,
            deepBottomProvider: deepBottomProvider,
            fabProvider: fabProvider,
            database: database);
        break;
      case 2:
        NoteCreation.copySelectedNotes(context: context);

        DeepToast.showToast(description: "Note copied successfully");

        deepBottomProvider.setSelection = false;
        selectionProvider.setSelection = false;
        fabProvider.setScrollDown = false;
        selectionProvider.getSelected.clear();

        break;
      default:
    }
  }
}
