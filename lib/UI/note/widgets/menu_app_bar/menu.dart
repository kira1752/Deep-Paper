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
import '../../../app_theme.dart';
import '../../../widgets/deep_snack_bar.dart';

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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        tooltip: StringResource.tooltipFolderMenu,
        icon: options(context: context),
        onSelected: (choice) {
          folder_menu.menuFolderSelected(
              context: context, drawerProvider: drawerProvider, choice: choice);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: optionRenameFolder(context: context),
                    title: Text(
                      StringResource.renameFolder,
                      style: menuItemStyle(context: context),
                    ),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: optionDelete(context: context),
                    title: Text(
                      StringResource.deleteFolder,
                      style: menuItemStyle(context: context),
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          tooltip: StringResource.tooltipTrashMenu,
          icon: options(context: context),
          onSelected: (choice) {
            final database =
            Provider.of<DeepPaperDatabase>(context, listen: false);

            if (choice == 0) trash_management.empty(database: database);

            showSnack(
                context: context,
                icon: successful(context: context),
                description: StringResource.trashEmptiedSuccessfully);
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: optionDelete(context: context),
                    title: Text(
                      StringResource.emptyTrashBin,
                      style: TextStyle(
                        fontSize: SizeHelper.getBodyText1,
                        color:
                        themeColorOpacity(context: context, opacity: .87),
                      ),
                    ),
                  ))
            ];
          }),
    );
  }
}
