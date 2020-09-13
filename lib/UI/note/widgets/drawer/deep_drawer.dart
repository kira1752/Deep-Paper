import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../data/deep.dart';
import '../../../../icons/my_icon.dart';
import '../../../../utility/extension.dart';
import '../../../widgets/deep_scrollbar.dart';
import 'drawer_default_item.dart';
import 'drawer_folder_item.dart';
import 'drawer_title.dart';
import 'folder_add_button.dart';

class DeepDrawer extends StatefulWidget {
  const DeepDrawer({Key key}) : super(key: key);

  @override
  _DeepDrawerState createState() => _DeepDrawerState();
}

class _DeepDrawerState extends State<DeepDrawer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final selectionProvider =
          Provider.of<SelectionProvider>(context, listen: false);
      final bottomNavBarProvider =
          Provider.of<DeepBottomProvider>(context, listen: false);

      final fabProvider = Provider.of<FABProvider>(context, listen: false);

      fabProvider.setScrollDown = false;

      if (selectionProvider.getSelection == true) {
        selectionProvider.setSelection = false;
        bottomNavBarProvider.setSelection = false;
        selectionProvider.getSelected.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    const defaultItemValue = 5;

    return RepaintBoundary(
      child: Drawer(
        child: Container(
          color: Theme.of(context).canvasColor,
          child: SafeArea(
              child: MultiProvider(
            providers: [
              FutureProvider<List<Note>>(
                  create: (context) => database.noteDao.getAllNotes()),
              StreamProvider(
                  create: (context) => database.folderNoteDao.watchFolder())
            ],
                child: Consumer<List<Note>>(builder: (context, noteList, _) {
              return Consumer<List<FolderNoteData>>(
                  child: const SizedBox(),
                  builder: (context, folderList, emptyState) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      child: folderList.isNull
                          ? emptyState
                          : DeepScrollbar(
                              key: const Key('Note Drawer Scrollbar'),
                              child: ScrollablePositionedList.builder(
                                  key: const PageStorageKey('Folder ListView'),
                                  physics: const ClampingScrollPhysics(),
                                  itemCount:
                                      folderList.length + defaultItemValue,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return const DrawerTitle();
                                    } else if (index == 1) {
                                      return DrawerDefaultItem(
                                        key: ValueKey('$index'),
                                        title: 'All Notes',
                                        setValue: 0,
                                        icon: MyIcon.square_edit,
                                        activeIcon: MyIcon.square_edit,
                                        total: noteList.isNull
                                            ? null
                                            : noteList
                                                .where(
                                                    (n) => n.isDeleted == false)
                                                .length,
                                      );
                                    } else if (index == 2) {
                                      return DrawerDefaultItem(
                                        key: ValueKey('$index'),
                                        title: 'Trash',
                                        setValue: 1,
                                        icon: MyIcon.trash,
                                        activeIcon: MyIcon.trash,
                                        total: noteList.isNull
                                            ? null
                                            : noteList
                                                .where(
                                                    (n) => n.isDeleted == true)
                                                .length,
                                      );
                                    } else if (index == 3) {
                                      return const FolderAddButton();
                                    } else if (index == 4) {
                                      return DrawerFolderItem(
                                        key: ValueKey('$index'),
                                        icon: MyIcon.folder,
                                        activeIcon: MyIcon.folder,
                                        index: 0,
                                        folder: null,
                                        total: noteList.isNull
                                            ? null
                                            : noteList
                                                .where((n) => n.folderID == 0)
                                                .where(
                                                    (n) => n.isDeleted == false)
                                                .length,
                                      );
                                    } else {
                                      return DrawerFolderItem(
                                        key: ValueKey('$index'),
                                        icon: MyIcon.folder,
                                        activeIcon: MyIcon.folder,
                                        index:
                                            folderList[index - defaultItemValue]
                                                .id,
                                        folder: folderList[
                                            index - defaultItemValue],
                                        total: noteList.isNull
                                            ? null
                                            : noteList
                                                .where((n) =>
                                                    n.folderID ==
                                                    folderList[index -
                                                            defaultItemValue]
                                                        .id)
                                                .where(
                                                    (n) => n.isDeleted == false)
                                                .length,
                                      );
                                    }
                                  }),
                            ),
                    );
                  });
            }),
          )),
        ),
      ),
    );
  }
}
