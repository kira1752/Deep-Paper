import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/note_creation.dart' as note_creation;
import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../data/deep.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_expand_base_dialog.dart';
import '../../../widgets/deep_snack_bar.dart';
import '../modal_field.dart';
import '../note_dialog.dart' as note_dialog;

Future openMoveToDialog(
    {@required BuildContext context,
    @required FolderNoteData currentFolder,
    @required int drawerIndex,
    @required SelectionProvider selectionProvider,
    @required BottomNavBarProvider deepBottomProvider,
    @required FABProvider fabProvider,
    @required DeepPaperDatabase database}) {
  final defaultItemValue = currentFolder.isNotNull || drawerIndex == 0 ? 1 : 1;

  return showDialog(
      context: context,
      builder: (context) => FutureProvider(
            create: (context) => database.folderNoteDao.getFolder(),
            child: Consumer<List<FolderNoteData>>(
              builder: (context, folderList, emptyState) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: folderList.isNull
                    ? emptyState
                    : _MoveToFolderDialog(
                        defaultItemValue: defaultItemValue,
                        folderList: folderList,
                        currentFolder: currentFolder,
                        drawerIndex: drawerIndex,
                        selectionProvider: selectionProvider,
                        deepBottomProvider: deepBottomProvider,
                        fabProvider: fabProvider,
                        database: database),
              ),
              child: const SizedBox(),
            ),
          ));
}

class _MoveToFolderDialog extends StatelessWidget {
  final int defaultItemValue;
  final List<FolderNoteData> folderList;
  final FolderNoteData currentFolder;
  final int drawerIndex;
  final SelectionProvider selectionProvider;
  final BottomNavBarProvider deepBottomProvider;
  final FABProvider fabProvider;
  final DeepPaperDatabase database;

  const _MoveToFolderDialog(
      {@required this.defaultItemValue,
      @required this.folderList,
      @required this.currentFolder,
      @required this.drawerIndex,
      @required this.selectionProvider,
      @required this.deepBottomProvider,
      @required this.fabProvider,
      @required this.database});

  @override
  Widget build(BuildContext context) {
    return DeepExpandBaseDialog(
      titlePadding: const EdgeInsets.all(0.0),
      actionsPadding: 0.0,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(bottom: Divider.createBorderSide(context))),
        child: Text(
          'Select folder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeHelper.headline6,
            fontWeight: FontWeight.w600,
            color: themeColorOpacity(context: context, opacity: .87),
          ),
        ),
      ),
      actions: [
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: Theme.of(context).accentColor.withOpacity(0.87),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: SizeHelper.modalButton,
                ),
              )),
        ),
      ],
      optionalWidget: Scrollbar(
        child: ListView.builder(
            cacheExtent: 100.0,
            physics: const BouncingScrollPhysics(),
            itemCount: folderList.length + defaultItemValue,
            shrinkWrap: true,
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            itemBuilder: (context, index) {
              if (index == 0) {
                return ModalField(
                  icon: FluentIcons.add_24_regular,
                  title: 'New folder',
                  onTap: () {
                    Navigator.pop(context);
                    note_dialog.openCreateFolderMoveToDialog(
                        context: context,
                        database: database,
                        currentFolder: currentFolder,
                        drawerIndex: drawerIndex,
                        selectionProvider: selectionProvider,
                        deepBottomProvider: deepBottomProvider,
                        fabProvider: fabProvider);
                  },
                );
              } else {
                if (currentFolder?.id !=
                    folderList[index - defaultItemValue].id) {
                  final folder = folderList[index - defaultItemValue];

                  return ModalField(
                    icon: folder.name == StringResource.mainFolder
                        ? FluentIcons.folder_briefcase_20_regular
                        : FluentIcons.folder_24_regular,
                    title: '${folder.name}',
                    onTap: () {
                      note_creation.moveToFolderBatch(
                          folder: folder,
                          selectionProvider: selectionProvider,
                          database: database);

                      Navigator.pop(context);

                      showSnack(
                          context: context,
                          icon: successful(context: context),
                          description: 'Note moved successfully');

                      deepBottomProvider.setSelection = false;
                      selectionProvider.setSelection = false;
                      fabProvider.setScrollDown = false;
                      selectionProvider.getSelected.clear();
                    },
                  );
                } else {
                  return const SizedBox();
                }
              }
            }),
      ),
    );
  }
}
