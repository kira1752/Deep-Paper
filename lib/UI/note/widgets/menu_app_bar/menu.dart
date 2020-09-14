import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/folder_menu.dart' as folder_menu;
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/trash_management.dart'
    as trash_management;
import '../../../../data/deep.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart' as app_theme;
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
          folder_menu.menuFolderSelected(
              context: context, drawerProvider: drawerProvider, choice: choice);
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
                  style: app_theme.darkPopupMenuItem(),
                ),
              )),
          PopupMenuItem(
              value: 1,
              child: ListTile(
                leading: IconResource.darkOptionsDelete,
                title: Text(
                  StringResource.deleteFolder,
                  style: app_theme.darkPopupMenuItem(),
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
            final database =
            Provider.of<DeepPaperDatabase>(context, listen: false);

            if (choice == 0) trash_management.empty(database: database);

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
