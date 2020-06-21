import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/bussiness_logic/note/selection_menu_logic.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) => provider.getIndexDrawerItem == 1,
      builder: (context, value, child) {
        if (value) {
          return TrashMenu();
        } else
          return NormalSelectionMenu();
      },
    );
  }
}

class TrashMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: StringResource.tooltipSelectionMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          SelectionMenuLogic.menuTrashSelected(
              context: context, choice: choice);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: IconResource.darkOptionsRestore,
                    title: Text(
                      StringResource.restore,
                      style: TextStyle(
                          fontSize: SizeHelper.getBodyText1,
                          color: Colors.white.withOpacity(0.87)),
                    ),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(
                      MyIcon.trash_empty,
                      color: Colors.white.withOpacity(0.60),
                    ),
                    title: Text(
                      "Delete forever",
                      style: TextStyle(
                          fontSize: SizeHelper.getBodyText1,
                          color: Colors.white.withOpacity(0.87)),
                    ),
                  ))
            ]);
  }
}

class NormalSelectionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        tooltip: StringResource.tooltipSelectionMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          SelectionMenuLogic.menuSelectionSelected(
              context: context, choice: choice);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: IconResource.darkOptionsDelete,
                    title: Text(
                      StringResource.delete,
                      style: AppTheme.darkPopupMenuItem(context),
                    ),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: IconResource.darkOptionsMoveTo,
                    title: Text(
                      StringResource.moveTo,
                      style: AppTheme.darkPopupMenuItem(context),
                    ),
                  )),
              PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: IconResource.darkOptionsCopy,
                    title: Text(
                      StringResource.copy,
                      style: AppTheme.darkPopupMenuItem(context),
                    ),
                  )),
            ]);
  }
}
