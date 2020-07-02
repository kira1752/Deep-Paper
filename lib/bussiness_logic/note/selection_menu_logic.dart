import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/UI/note/widgets/move_to_folder.dart';
import 'package:deep_paper/bussiness_logic/note/note_creation.dart';
import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/bussiness_logic/note/trash_management.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionMenuLogic {
  SelectionMenuLogic._();

  static void menuTrashSelected(
      {@required BuildContext context, @required int choice}) {
    switch (choice) {
      case 0:
        TrashManagement.restoreBatch(context: context);

        DeepToast.showToast(description: "Note restored successfully");

        Provider.of<DeepBottomProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false)
            .getSelected
            .clear();

        break;

      case 1:
        TrashManagement.deleteBatch(context: context);

        DeepToast.showToast(description: "Note deleted successfully");

        Provider.of<DeepBottomProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false)
            .getSelected
            .clear();
        break;

      default:
        break;
    }
  }

  static Future<void> menuSelectionSelected(
      {@required BuildContext context, @required int choice}) async {
    switch (choice) {
      case 0:
        NoteCreation.moveToTrashBatch(context: context);

        DeepToast.showToast(description: "Note moved to Trash Bin");

        Provider.of<DeepBottomProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false)
            .getSelected
            .clear();
        break;
      case 1:
        final currentFolder =
            Provider.of<NoteDrawerProvider>(context, listen: false).getFolder;

        final drawerIndex =
            Provider.of<NoteDrawerProvider>(context, listen: false)
                .getIndexDrawerItem;

        final selectionProvider =
            Provider.of<SelectionProvider>(context, listen: false);

        final deepBottomProvider =
            Provider.of<DeepBottomProvider>(context, listen: false);

        final database = Provider.of<DeepPaperDatabase>(context, listen: false);

        MoveToFolder.openMoveToDialog(
            context: context,
            currentFolder: currentFolder,
            drawerIndex: drawerIndex,
            selectionProvider: selectionProvider,
            deepBottomProvider: deepBottomProvider,
            database: database);
        break;
      case 2:
        NoteCreation.copySelectedNotes(context: context);

        DeepToast.showToast(description: "Note copied successfully");

        Provider.of<DeepBottomProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false)
            .getSelected
            .clear();
        break;
      default:
    }
  }
}
