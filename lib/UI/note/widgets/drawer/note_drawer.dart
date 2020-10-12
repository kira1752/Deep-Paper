import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../data/deep.dart';
import '../../../../utility/extension.dart';
import '../../../widgets/deep_drawer.dart';
import 'drawer_default_item.dart';
import 'drawer_folder_item.dart';
import 'drawer_title.dart';
import 'drawer_total_notes.dart';
import 'folder_add_button.dart';

class NoteDrawer extends StatefulWidget {
  const NoteDrawer();

  @override
  _NoteDrawerState createState() => _NoteDrawerState();
}

class _NoteDrawerState extends State<NoteDrawer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final selectionProvider = context.read<SelectionProvider>();
      final bottomNavBarProvider = context.read<BottomNavBarProvider>();
      final fabProvider = context.read<FABProvider>();

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
      child: DeepDrawer(
        child: MultiProvider(
            providers: [
              StreamProvider<List<Note>>(
                  create: (context) => database.noteDao.watchAllNotes()),
              StreamProvider(
                  create: (context) => database.folderNoteDao.watchFolder())
            ],
            builder: (context, _) {
              final folderList = context.watch<List<FolderNoteData>>();
              final noteList = context.watch<List<Note>>();

              final countAllNotesAvailable = noteList.isNull
                  ? 0
                  : noteList.where((n) => n.isDeleted == false).length;
              final countAllDeletedNotes = noteList.isNull
                  ? 0
                  : noteList.where((n) => n.isDeleted == true).length;
              final countNotesMainFolder = noteList.isNull
                  ? null
                  : noteList
                      .where((n) => n.folderID == 0)
                      .where((n) => n.isDeleted == false)
                      .length;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: folderList.isNull || noteList.isNull
                    ? const SizedBox()
                    : Scrollbar(
                        thickness: 4,
                        radius: const Radius.circular(12.0),
                        key: const Key('Note Drawer Scrollbar'),
                        child: ScrollablePositionedList.builder(
                            key: const PageStorageKey('Folder ListView'),
                            physics: const BouncingScrollPhysics(),
                            itemCount: folderList.length + defaultItemValue,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return const DrawerTitle();
                              } else if (index == 1) {
                                return DrawerDefaultItem(
                                  key: ValueKey('$index'),
                                  title: 'All Notes',
                                  setValue: 0,
                                  icon: FluentIcons.note_24_filled,
                                  total:
                                      DrawerTotalNotes(countAllNotesAvailable),
                                );
                              } else if (index == 2) {
                                return DrawerDefaultItem(
                                  key: ValueKey('$index'),
                                  title: 'Trash',
                                  setValue: 1,
                                  icon: FluentIcons.delete_24_filled,
                                  total: DrawerTotalNotes(countAllDeletedNotes),
                                );
                              } else if (index == 3) {
                                return const FolderAddButton();
                              } else if (index == 4) {
                                return DrawerFolderItem(
                                    key: ValueKey('$index'),
                                    icon:
                                        FluentIcons.folder_briefcase_20_filled,
                                    id: 0,
                                    folder: null,
                                    total:
                                        DrawerTotalNotes(countNotesMainFolder));
                              } else {
                                final id =
                                    folderList[index - defaultItemValue].id;
                                final folder =
                                    folderList[index - defaultItemValue];
                                final total = noteList
                                    .where((n) =>
                                        n.folderID ==
                                        folderList[index - defaultItemValue].id)
                                    .where((n) => n.isDeleted == false)
                                    .length;

                                return DrawerFolderItem(
                                    key: ValueKey('$index'),
                                    icon: FluentIcons.folder_24_filled,
                                    id: id,
                                    folder: folder,
                                    total: DrawerTotalNotes(total));
                              }
                            }),
                      ),
              );
            }),
      ),
    );
  }
}
