import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/bussiness_logic/note/default_menu_logic.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/bussiness_logic/note/trash_management.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) =>
          provider.getFolder != null && provider.getIndexDrawerItem == null,
      builder: (context, showMenu, child) {
        if (showMenu) {
          return FolderMenu();
        } else
          return TrashMenu();
      },
    );
  }
}

class FolderMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: StringResource.tooltipFolderMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          DefaultMenuLogic.menuFolderSelected(context: context, choice: choice);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: IconResource.darkOptionsRenameFolder,
                    title: Text(
                      StringResource.renameFolder,
                      style: AppTheme.darkPopupMenuItem(context),
                    ),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: IconResource.darkOptionsDelete,
                    title: Text(
                      StringResource.deleteFolder,
                      style: AppTheme.darkPopupMenuItem(context),
                    ),
                  )),
            ]);
  }
}

class TrashMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    return StreamProvider<List<Note>>(
      create: (context) => database.noteDao.watchAllDeletedNotes(),
      child: Selector2<NoteDrawerProvider, List<Note>, bool>(
        selector: (context, provider, data) =>
            provider.getIndexDrawerItem == 1 && data != null && data.isNotEmpty,
        builder: (context, showMenu, child) {
          return Visibility(
            visible: showMenu,
            child: PopupMenuButton(
                tooltip: StringResource.tooltipTrashMenu,
                icon: IconResource.darkOptions,
                onSelected: (choice) {
                  if (choice == 0) TrashManagement.empty(context: context);

                  DeepToast.showToast(
                      description: StringResource.trashEmptiedSuccesfully);
                },
                padding: EdgeInsets.all(18.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
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
        },
      ),
    );
  }
}
