import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../UI/widgets/deep_snack_bar.dart';
import '../../data/deep.dart';
import '../../resource/icon_resource.dart';
import '../../resource/string_resource.dart';
import 'folder_menu.dart';
import 'provider/deep_bottom_provider.dart';
import 'provider/fab_provider.dart';
import 'provider/note_drawer_provider.dart';
import 'provider/selection_provider.dart';
import 'selection_menu_logic.dart';
import 'trash_management.dart';

PopupMenuItemSelected<int> normalOnSelected(BuildContext context) {
  final showFolderMenu = context.select((NoteDrawerProvider value) =>
      value.getFolder != null && value.getIndexDrawerItem == null);

  Function trashMenu = (int choice) {
    if (choice == 0) {
      empty(database: context.read<DeepPaperDatabase>());
    }

    showSnack(
        context: context,
        icon: successful(context: context),
        description: StringResource.trashEmptiedSuccessfully);
  };

  Function folderMenu = (int choice) {
    menuFolderSelected(
        context: context,
        drawerProvider: context.read<NoteDrawerProvider>(),
        choice: choice);
  };

  var onSelected = showFolderMenu ? folderMenu : trashMenu;

  return onSelected;
}

PopupMenuItemSelected<int> selectionOnSelected(BuildContext context) {
  final showTrashSelection = context
      .select((NoteDrawerProvider value) => value.getIndexDrawerItem == 1);

  final trashMenu = (int choice) {
    menuTrashSelected(
        context: context,
        database: context.read<DeepPaperDatabase>(),
        selectionProvider: context.read<SelectionProvider>(),
        deepBottomProvider: context.read<BottomNavBarProvider>(),
        fabProvider: context.read<FABProvider>(),
        choice: choice);
  };

  final normalSelection = (int choice) {
    menuSelectionSelected(
        context: context,
        database: context.read<DeepPaperDatabase>(),
        deepBottomProvider: context.read<BottomNavBarProvider>(),
        selectionProvider: context.read<SelectionProvider>(),
        fabProvider: context.read<FABProvider>(),
        drawerProvider: context.read<NoteDrawerProvider>(),
        choice: choice);
  };

  final onSelected = showTrashSelection ? trashMenu : normalSelection;

  return onSelected;
}
