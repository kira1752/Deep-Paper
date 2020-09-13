import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/default_menu_logic.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/trash_management.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_toast.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) =>
          provider.getFolder != null && provider.getIndexDrawerItem == null,
      builder: (context, showTrashMenu, trashMenu) =>
          showTrashMenu ? const FolderMenu() : trashMenu,
      child: const TrashMenu(),
    );
  }
}

class FolderMenu extends StatelessWidget {
  const FolderMenu();

  @override
  Widget build(BuildContext context) {
    final drawerProvider =
    Provider.of<NoteDrawerProvider>(context, listen: false);
    return PopupMenuButton(
        tooltip: StringResource.tooltipFolderMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          DefaultMenuLogic.menuFolderSelected(
              drawerProvider: drawerProvider, choice: choice);
        },
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) =>
        [
          PopupMenuItem(
              value: 0,
              child: ListTile(
                leading: IconResource.darkOptionsRenameFolder,
                title: Text(
                  StringResource.renameFolder,
                  style: AppTheme.darkPopupMenuItem(),
                ),
              )),
          PopupMenuItem(
              value: 1,
              child: ListTile(
                leading: IconResource.darkOptionsDelete,
                title: Text(
                  StringResource.deleteFolder,
                  style: AppTheme.darkPopupMenuItem(),
                ),
              )),
        ]);
  }
}

class TrashMenu extends StatelessWidget {
  const TrashMenu();

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) =>
      provider.getIndexDrawerItem == 1 && provider.isTrashExist,
      builder: (context, showTrashMenu, trashMenu) =>
          Visibility(visible: showTrashMenu, child: trashMenu),
      child: PopupMenuButton(
          tooltip: StringResource.tooltipTrashMenu,
          icon: IconResource.darkOptions,
          onSelected: (choice) {
            if (choice == 0) TrashManagement.empty();

            DeepToast.showToast(
                description: StringResource.trashEmptiedSuccessfully);
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: IconResource.darkOptionsDelete,
                    title: Text(
                      StringResource.emptyTrashBin,
                      style: TextStyle(
                          fontSize: SizeHelper.getBodyText1,
                          color: Colors.white.withOpacity(0.87)),
                    ),
                  ))
            ];
          }),
    );
  }
}
