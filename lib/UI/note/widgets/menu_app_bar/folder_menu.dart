import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/note/widgets/bottom_modal.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) =>
          provider.getFolder != null && provider.getIndexDrawerItem == null,
      builder: (context, showMenu, child) {
        return Visibility(
          visible: showMenu,
          child: PopupMenuButton(
              tooltip: StringResource().tooltipFolderMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white70,
              ),
              onSelected: (choice) {
                _onFolderMenuSelected(context: context, choice: choice);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 0,
                        child: ListTile(
                          leading: IconResource().darkRenameFolder,
                          title: Text(
                            "Rename Folder",
                            style: AppTheme().darkPopupMenuItem(context),
                          ),
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: IconResource().darkDeleteFolder,
                          title: Text(
                            "Delete Folder",
                            style: AppTheme().darkPopupMenuItem(context),
                          ),
                        )),
                  ]),
        );
      },
    );
  }

  void _onFolderMenuSelected(
      {@required BuildContext context, @required int choice}) async {
    switch (choice) {
      case 0:
        await BottomModal.openRenameFolderDialog(context: context);
        break;
      case 1:
        await BottomModal.openDeleteFolderDialog(context: context);
        break;
      default:
    }
  }
}
