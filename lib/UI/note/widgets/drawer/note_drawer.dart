import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../data/deep.dart';
import '../../../../model/note/drawer_folder_model.dart';
import '../../../../model/note/drawer_note_model.dart';
import '../../../../resource/string_resource.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    const defaultItemValue = 4;
    return RepaintBoundary(
      child: DeepDrawer(
        child: MultiProvider(
            providers: [
              StreamProvider<List<DrawerFolderModel>>(
                create: (context) =>
                    database.folderNoteDao.watchFolderWithCount(),
              ),
              StreamProvider<DrawerNoteModel>(
                create: (context) => database.noteDao.watchCountAllNotes(),
              )
            ],
            builder: (context, _) {
              final folderList = context.watch<List<DrawerFolderModel>>();
              final countNotes = context.watch<DrawerNoteModel>();

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: folderList.isNull || countNotes.isNull
                    ? const SizedBox()
                    : ScrollablePositionedList.builder(
                        key: const PageStorageKey('Folder ListView'),
                        physics: const BouncingScrollPhysics(),
                        itemCount: folderList.length + defaultItemValue,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const DrawerTitle();
                          } else if (index == 1) {
                            return DrawerDefaultItem(
                              key: ValueKey('$index'),
                              title: StringResource.all_notes,
                              setValue: 0,
                              icon: FluentIcons.note_24_regular,
                              activeIcon: FluentIcons.note_24_filled,
                              total: DrawerTotalNotes(
                                  countNotes.countAvailableNotes),
                            );
                          } else if (index == 2) {
                            return DrawerDefaultItem(
                              key: ValueKey('$index'),
                              title: StringResource.trash,
                              setValue: 1,
                              icon: FluentIcons.delete_24_regular,
                              activeIcon: FluentIcons.delete_24_filled,
                              total: DrawerTotalNotes(
                                  countNotes.countDeletedNotes),
                            );
                          } else if (index == 3) {
                            return const FolderAddButton();
                          } else {
                            final id =
                                folderList[index - defaultItemValue].folder.id;
                            final folder =
                                folderList[index - defaultItemValue].folder;
                            final total =
                                folderList[index - defaultItemValue].count;

                            return DrawerFolderItem(
                                key: ValueKey('$index'),
                                icon: folder.name == StringResource.mainFolder
                                    ? FluentIcons.folder_briefcase_20_regular
                                    : FluentIcons.folder_24_regular,
                                activeIcon:
                                    folder.name == StringResource.mainFolder
                                        ? FluentIcons.folder_briefcase_20_filled
                                        : FluentIcons.folder_24_filled,
                                id: id,
                                folder: folder,
                                total: DrawerTotalNotes(total));
                          }
                        }),
              );
            }),
      ),
    );
  }
}
