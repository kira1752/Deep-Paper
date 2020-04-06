import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_default_item.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_folder_item.dart';
import 'package:deep_paper/note/widgets/drawer/drawer_title.dart';
import 'package:deep_paper/note/widgets/drawer/folder_add_button.dart';
import 'package:deep_paper/widgets/deep_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:deep_paper/utility/extension.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    final defaultItemValue = drawerProvider.getDefaultItemValue;

    return Container(
      color: Theme.of(context).primaryColor,
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
              duration: Duration(milliseconds: 450),
              child: folderList.isNull
                  ? Container()
                  : DeepScrollbar(
                      key: Key("Note Drawer Scrollbar"),
                      child: ScrollablePositionedList.builder(
                          key: const PageStorageKey("Folder ListView"),
                          physics: ClampingScrollPhysics(),
                          itemCount: folderList.length + defaultItemValue,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return DrawerTitle(
                                  key: Key("$index"), title: "NOTE");
                            } else if (index == 1) {
                              return DrawerDefaultItem(
                                key: Key("$index"),
                                title: "All Notes",
                                setValue: 0,
                                icon: MyIcon.library_books_outline,
                                activeIcon: Icons.library_books,
                                total: noteList == null
                                    ? null
                                    : noteList
                                        .where((n) => n.isDeleted == false)
                                        .length,
                              );
                            } else if (index == 2) {
                              return DrawerDefaultItem(
                                key: Key("$index"),
                                title: "Trash",
                                setValue: 1,
                                icon: MyIcon.trash_empty,
                                activeIcon: MyIcon.trash,
                                total: noteList == null
                                    ? null
                                    : noteList
                                        .where((n) => n.isDeleted == true)
                                        .length,
                              );
                            } else if (index == 3) {
                              return FolderAddButton(
                                key: Key("$index"),
                              );
                            } else {
                              return DrawerFolderItem(
                                key: Key("$index"),
                                index: index - defaultItemValue,
                                folder: folderList[index - defaultItemValue],
                                total: noteList == null
                                    ? null
                                    : noteList
                                        .where((n) =>
                                            n.folderID ==
                                            folderList[index - defaultItemValue]
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
    );
  }
}
