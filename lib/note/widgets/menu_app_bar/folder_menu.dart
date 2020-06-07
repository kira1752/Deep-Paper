import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:deep_paper/utility/size_helper.dart';
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
              tooltip: "Open Folder Menu",
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
                          leading: Icon(
                            MyIcon.edit_outline,
                            color: Colors.white.withOpacity(0.60),
                          ),
                          title: Text(
                            "Rename Folder",
                            style: TextStyle(fontSize: SizeHelper.getBodyText1),
                          ),
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: Icon(MyIcon.trash_empty,
                              color: Colors.white.withOpacity(0.60)),
                          title: Text(
                            "Delete Folder",
                            style: TextStyle(fontSize: SizeHelper.getBodyText1),
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
