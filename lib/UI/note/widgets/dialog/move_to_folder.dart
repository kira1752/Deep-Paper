import 'package:deep_paper/UI/note/widgets/dialog/note_dialog.dart';
import 'package:deep_paper/UI/widgets/deep_expand_base_dialog.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/UI/widgets/deep_scrollbar.dart';
import 'package:deep_paper/UI/widgets/deep_toast.dart';
import 'package:deep_paper/business_logic/note/note_creation.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveToFolder {
  static Future openMoveToDialog(
      {@required BuildContext context,
      @required FolderNoteData currentFolder,
      @required int drawerIndex,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      @required FABProvider fabProvider,
      @required DeepPaperDatabase database}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final defaultItemValue =
        currentFolder.isNotNull || drawerIndex == 0 ? 2 : 1;

    return showDialog(
        context: context,
        builder: (context) {
          return FutureProvider(
            create: (context) => database.folderNoteDao.getFolder(),
            child: Consumer<List<FolderNoteData>>(
              builder: (context, folderList, widget) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                child: folderList.isNull
                    ? const SizedBox()
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
            ),
          );
        });
  }
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

  _MoveToFolderDialog({@required this.defaultItemValue,
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
                    color: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(.20)))),
        child: Text(
          'Select folder',
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: SizeHelper.getTitle),
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
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: SizeHelper.getModalButton,
                ),
              )),
        ),
      ],
      optionalWidget: DeepScrollbar(
        child: ScrollConfiguration(
          behavior: DeepScrollBehavior(),
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
                        Navigator.of(context).pop();

                        DeepDialog.openCreateFolderMoveToDialog(
                            context: context,
                            currentFolder: currentFolder,
                            drawerIndex: drawerIndex,
                            selectionProvider: selectionProvider,
                            deepBottomProvider: deepBottomProvider,
                            fabProvider: fabProvider);
                      },
                      leading: const Icon(
                        MyIcon.plus,
                        color: Colors.white70,
                      ),
                      title: Text(
                        'New folder',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(
                            color: Colors.white70,
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
                          NoteCreation.moveToFolderBatch(
                              context: context,
                              folder: null,
                              selectionProvider: selectionProvider,
                              database: database);

                          Navigator.of(context).pop();

                          DeepToast.showToast(
                              description: 'Note moved successfully');

                          deepBottomProvider.setSelection = false;

                          selectionProvider.setSelection = false;

                          fabProvider.setScrollDown = false;

                          selectionProvider.getSelected.clear();
                        },
                        leading: const Icon(
                          MyIcon.folder,
                          color: Colors.white70,
                        ),
                        title: Text(
                          'Main folder',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: Colors.white70,
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
                          NoteCreation.moveToFolderBatch(
                              context: context,
                              folder: folder,
                              selectionProvider: selectionProvider,
                              database: database);

                          Navigator.of(context).pop();

                          DeepToast.showToast(
                              description: 'Note moved successfully');

                          deepBottomProvider.setSelection = false;

                          selectionProvider.setSelection = false;

                          fabProvider.setScrollDown = false;

                          selectionProvider.getSelected.clear();
                        },
                        leading: const Icon(
                          MyIcon.folder,
                          color: Colors.white70,
                        ),
                        title: Text(
                          '${folder.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: Colors.white70,
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
                          NoteCreation.moveToFolderBatch(
                              context: context,
                              folder: null,
                              selectionProvider: selectionProvider,
                              database: database);

                          Navigator.of(context).pop();

                          DeepToast.showToast(
                              description: 'Note moved successfully');

                          deepBottomProvider.setSelection = false;

                          selectionProvider.setSelection = false;

                          fabProvider.setScrollDown = false;

                          selectionProvider.getSelected.clear();
                        },
                        leading: const Icon(
                          MyIcon.folder,
                          color: Colors.white70,
                        ),
                        title: Text(
                          'Main folder',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: Colors.white70,
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
                          NoteCreation.moveToFolderBatch(
                              context: context,
                              folder: folder,
                              selectionProvider: selectionProvider,
                              database: database);

                          Navigator.of(context).pop();

                          DeepToast.showToast(
                              description: 'Note moved successfully');

                          deepBottomProvider.setSelection = false;

                          selectionProvider.setSelection = false;

                          fabProvider.setScrollDown = false;

                          selectionProvider.getSelected.clear();
                        },
                        leading: const Icon(
                          MyIcon.folder,
                          color: Colors.white70,
                        ),
                        title: Text(
                          '${folder.name}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                              color: Colors.white70,
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
                        NoteCreation.moveToFolderBatch(
                            context: context,
                            folder: folder,
                            selectionProvider: selectionProvider,
                            database: database);

                        Navigator.of(context).pop();

                        DeepToast.showToast(
                            description: 'Note moved successfully');

                        deepBottomProvider.setSelection = false;

                        selectionProvider.setSelection = false;

                        fabProvider.setScrollDown = false;

                        selectionProvider.getSelected.clear();
                      },
                      leading: const Icon(
                        MyIcon.folder,
                        color: Colors.white70,
                      ),
                      title: Text(
                        '${folder.name}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(
                            color: Colors.white70,
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
