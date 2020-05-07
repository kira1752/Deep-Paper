import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_default_item.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_folder_item.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_title.dart';
import 'package:deep_paper/note/widgets/drawer/folder_add_button.dart';
import 'package:deep_paper/widgets/deep_scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:deep_paper/utility/extension.dart';

class DeepDrawer extends StatefulWidget {
  DeepDrawer({Key key}) : super(key: key);

  @override
  _DeepDrawerState createState() => _DeepDrawerState();
}

class _DeepDrawerState extends State<DeepDrawer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<SelectionProvider>(context, listen: false);
      var bottomNavBarProvider =
          Provider.of<DeepBottomProvider>(context, listen: false);

      if (provider.getSelection == true) {
        provider.setSelection = false;
        bottomNavBarProvider.setSelection = false;
        provider.getSelected.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);
    const int defaultItemValue = 5;

    return Drawer(
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
          child: Consumer<List<Note>>(builder: (context, noteList, widget) {
            return Consumer<List<FolderNoteData>>(
                builder: (context, folderList, widget) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: folderList.isNull
                    ? const SizedBox()
                    : DeepScrollbar(
                        key: Key("Note Drawer Scrollbar"),
                        child: ScrollablePositionedList.builder(
                            key: const PageStorageKey("Folder ListView"),
                            physics: const ClampingScrollPhysics(),
                            itemCount: folderList.length + defaultItemValue,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return DrawerTitle(
                                    key: ValueKey("$index"), title: "NOTE");
                              } else if (index == 1) {
                                return DrawerDefaultItem(
                                  key: ValueKey("$index"),
                                  title: "All Notes",
                                  setValue: 0,
                                  icon: MyIcon.library_books_outline,
                                  activeIcon: Icons.library_books,
                                  total: noteList.isNull
                                      ? null
                                      : noteList
                                          .where((n) => n.isDeleted == false)
                                          .length,
                                );
                              } else if (index == 2) {
                                return DrawerDefaultItem(
                                  key: ValueKey("$index"),
                                  title: "Trash",
                                  setValue: 1,
                                  icon: MyIcon.trash_empty,
                                  activeIcon: MyIcon.trash,
                                  total: noteList.isNull
                                      ? null
                                      : noteList
                                          .where((n) => n.isDeleted == true)
                                          .length,
                                );
                              } else if (index == 3) {
                                return FolderAddButton(
                                  key: ValueKey("$index"),
                                );
                              } else if (index == 4) {
                                return DrawerFolderItem(
                                  key: ValueKey("$index"),
                                  icon: Icons.folder_shared,
                                  activeIcon: Icons.folder_shared,
                                  index: 0,
                                  folder: null,
                                  total: noteList.isNull
                                      ? null
                                      : noteList
                                          .where((n) => n.folderID == 0)
                                          .where((n) => n.isDeleted == false)
                                          .length,
                                );
                              } else {
                                return DrawerFolderItem(
                                  key: ValueKey("$index"),
                                  icon: Icons.folder_open,
                                  activeIcon: Icons.folder,
                                  index:
                                      folderList[index - defaultItemValue].id,
                                  folder: folderList[index - defaultItemValue],
                                  total: noteList.isNull
                                      ? null
                                      : noteList
                                          .where((n) =>
                                              n.folderID ==
                                              folderList[
                                                      index - defaultItemValue]
                                                  .id)
                                          .where((n) => n.isDeleted == false)
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
    );
  }
}
