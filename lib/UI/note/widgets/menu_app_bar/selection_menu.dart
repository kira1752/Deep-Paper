import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../business_logic/note/selection_menu_logic.dart';
import '../../../../icons/my_icon.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class SelectionMenu extends StatelessWidget {
  const SelectionMenu();

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) => provider.getIndexDrawerItem == 1,
      builder: (context, showTrashSelection, normalSelectionMenu) =>
          showTrashSelection ? _TrashMenu : normalSelectionMenu,
      child: const _NormalSelectionMenu(),
    );
  }
}

class _TrashMenu extends StatelessWidget {
  const _TrashMenu();

  @override
  Widget build(BuildContext context) {
    final selectionProvider =
    Provider.of<SelectionProvider>(context, listen: false);
    final deepBottomProvider =
    Provider.of<DeepBottomProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    return PopupMenuButton(
        tooltip: StringResource.tooltipSelectionMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          SelectionMenuLogic.menuTrashSelected(
              selectionProvider: selectionProvider,
              deepBottomProvider: deepBottomProvider,
              fabProvider: fabProvider,
              choice: choice);
        },
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) =>
        [
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
                  MyIcon.trash,
                  color: Colors.white.withOpacity(0.60),
                ),
                title: Text(
                  'Delete forever',
                  style: TextStyle(
                      fontSize: SizeHelper.getBodyText1,
                      color: Colors.white.withOpacity(0.87)),
                ),
              ))
        ]);
  }
}

class _NormalSelectionMenu extends StatelessWidget {
  const _NormalSelectionMenu();

  @override
  Widget build(BuildContext context) {
    final deepBottomProvider =
    Provider.of<DeepBottomProvider>(context, listen: false);
    final selectionProvider =
    Provider.of<SelectionProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);
    final drawerProvider =
    Provider.of<NoteDrawerProvider>(context, listen: false);

    return PopupMenuButton(
        tooltip: StringResource.tooltipSelectionMenu,
        icon: IconResource.darkOptions,
        onSelected: (choice) {
          SelectionMenuLogic.menuSelectionSelected(
              deepBottomProvider: deepBottomProvider,
              selectionProvider: selectionProvider,
              fabProvider: fabProvider,
              drawerProvider: drawerProvider,
              choice: choice);
        },
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (context) =>
        [
          PopupMenuItem(
              value: 0,
              child: ListTile(
                leading: IconResource.darkOptionsDelete,
                title: Text(
                  StringResource.delete,
                  style: AppTheme.darkPopupMenuItem(),
                ),
              )),
          PopupMenuItem(
              value: 1,
              child: ListTile(
                leading: IconResource.darkOptionsMoveTo,
                title: Text(
                  StringResource.moveTo,
                  style: AppTheme.darkPopupMenuItem(),
                ),
              )),
          PopupMenuItem(
              value: 2,
              child: ListTile(
                leading: IconResource.darkOptionsCopy,
                title: Text(
                  StringResource.copy,
                  style: AppTheme.darkPopupMenuItem(),
                ),
              )),
        ]);
  }
}
