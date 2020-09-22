import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/note_creation.dart' as note_creation;
import '../../../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../../../business_logic/note/provider/fab_provider.dart';
import '../../../../business_logic/note/provider/selection_provider.dart';
import '../../../../data/deep.dart';
import '../../../../icons/my_icon.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_expand_base_dialog.dart';
import '../../../widgets/deep_scroll_behavior.dart';
import '../../../widgets/deep_scrollbar.dart';
import '../../../widgets/deep_snack_bar.dart';
import 'note_dialog.dart' as note_dialog;

Future openMoveToDialog(
    {@required BuildContext context,
    @required FolderNoteData currentFolder,
    @required int drawerIndex,
    @required SelectionProvider selectionProvider,
    @required DeepBottomProvider deepBottomProvider,
    @required FABProvider fabProvider,
    @required DeepPaperDatabase database}) {
  final defaultItemValue = currentFolder.isNotNull || drawerIndex == 0 ? 2 : 1;

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
  final DeepBottomProvider deepBottomProvider;
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
      titlePadding: const EdgeInsets.symmetric(horizontal: 24.0),
      actionsPadding: 0.0,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).accentColor.withOpacity(.20)))),
        child: Text(
          'Select folder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeHelper.getHeadline6,
            fontWeight: FontWeight.w600,
            color: themeColorOpacity(context: context, opacity: .87),
          ),
        ),
      ),
      actions: [
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: Theme
                  .of(context)
                  .accentColor
                  .withOpacity(0.87),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: SizeHelper.getModalButton,
                ),
              )),
        ),
      ],
      optionalWidget: DeepScrollbar(
        child: ScrollConfiguration(
          behavior: const DeepScrollBehavior(),
          child: ListView.builder(
              cacheExtent: 100.0,
              itemCount: folderList.length + defaultItemValue,
              shrinkWrap: true,
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Material(
                    color: Colors.transparent,
                    shape: const StadiumBorder(),
                    child: ListTile(
                      shape: const StadiumBorder(),
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
                      leading: Icon(
                        MyIcon.plus,
                        color: themeColorOpacity(context: context, opacity: .7),
                      ),
                      title: Text(
                        'New folder',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            fontSize: SizeHelper.getModalButton),
                      ),
                    ),
                  );
                } else if (currentFolder.isNotNull) {
                  if (index == 1) {
                    return Material(
                      color: Colors.transparent,
                      shape: const StadiumBorder(),
                      child: ListTile(
                        shape: const StadiumBorder(),
                        onTap: () {
                          note_creation.moveToFolderBatch(
                              folder: null,
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
                        leading: Icon(
                          MyIcon.folder,
                          color:
                          themeColorOpacity(context: context, opacity: .7),
                        ),
                        title: Text(
                          StringResource.mainFolder,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .7),
                              fontSize: SizeHelper.getModalButton),
                        ),
                      ),
                    );
                  } else if (currentFolder.id !=
                      folderList[index - defaultItemValue].id) {
                    final folder = folderList[index - defaultItemValue];

                    return Material(
                      color: Colors.transparent,
                      shape: const StadiumBorder(),
                      child: ListTile(
                        shape: const StadiumBorder(),
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
                        leading: Icon(
                          MyIcon.folder,
                          color:
                          themeColorOpacity(context: context, opacity: .7),
                        ),
                        title: Text(
                          '${folder.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .7),
                              fontSize: SizeHelper.getModalButton),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else if (drawerIndex == 0) {
                  if (index == 1) {
                    return Material(
                      color: Colors.transparent,
                      shape: const StadiumBorder(),
                      child: ListTile(
                        shape: const StadiumBorder(),
                        onTap: () {
                          note_creation.moveToFolderBatch(
                              folder: null,
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
                        leading: Icon(
                          MyIcon.folder,
                          color:
                          themeColorOpacity(context: context, opacity: .87),
                        ),
                        title: Text(
                          StringResource.mainFolder,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .87),
                              fontSize: SizeHelper.getModalButton),
                        ),
                      ),
                    );
                  } else {
                    final folder = folderList[index - defaultItemValue];

                    return Material(
                      color: Colors.transparent,
                      shape: const StadiumBorder(),
                      child: ListTile(
                        shape: const StadiumBorder(),
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
                        leading: Icon(
                          MyIcon.folder,
                          color:
                          themeColorOpacity(context: context, opacity: .87),
                        ),
                        title: Text(
                          '${folder.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .7),
                              fontSize: SizeHelper.getModalButton),
                        ),
                      ),
                    );
                  }
                } else {
                  final folder = folderList[index - defaultItemValue];

                  return Material(
                    color: Colors.transparent,
                    shape: const StadiumBorder(),
                    child: ListTile(
                      shape: const StadiumBorder(),
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
                      leading: Icon(
                        MyIcon.folder,
                        color: themeColorOpacity(context: context, opacity: .7),
                      ),
                      title: Text(
                        '${folder.name}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .7),
                            fontSize: SizeHelper.getModalButton),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
