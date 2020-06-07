import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/note/widgets/move_to_folder.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NormalSelectionAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white70,
          ),
          onPressed: () {
            Provider.of<DeepBottomProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .getSelected
                .clear();
          }),
      actions: <Widget>[
        PopupMenuButton(
            tooltip: "Open Selection Menu",
            icon: Icon(
              Icons.more_vert,
              color: Colors.white70,
            ),
            onSelected: (choice) {
              _onNormalSelected(context: context, choice: choice);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        leading: Icon(MyIcon.trash_empty,
                            color: Colors.white.withOpacity(0.60)),
                        title: Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: SizeHelper.getBodyText1,
                              color: Colors.white.withOpacity(0.87)),
                        ),
                      )),
                  PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(
                          MyIcon.move_to,
                          color: Colors.white.withOpacity(0.60),
                        ),
                        title: Text(
                          "Move to",
                          style: TextStyle(
                              fontSize: SizeHelper.getBodyText1,
                              color: Colors.white.withOpacity(0.87)),
                        ),
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.content_copy,
                            color: Colors.white.withOpacity(0.60)),
                        title: Text(
                          "Make a copy",
                          style: TextStyle(
                              fontSize: SizeHelper.getBodyText1,
                              color: Colors.white.withOpacity(0.87)),
                        ),
                      )),
                ]),
      ],
      title: Selector<SelectionProvider, int>(
        builder: (context, count, child) {
          return Text('$count selected',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: SizeHelper.getHeadline5));
        },
        selector: (context, provider) => provider.getSelected.length,
      ),
    );
  }

  Future<void> _onNormalSelected(
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
