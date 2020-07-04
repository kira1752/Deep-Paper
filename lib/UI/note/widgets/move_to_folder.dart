import 'package:deep_paper/UI/note/widgets/deep_dialog.dart';
import 'package:deep_paper/UI/note/widgets/deep_toast.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/UI/widgets/deep_scrollbar.dart';
import 'package:deep_paper/bussiness_logic/note/note_creation.dart';
import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
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
      @required DeepPaperDatabase database}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final int defaultItemValue =
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
                    : Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 24.0,
                                  left: 24.0,
                                  right: 24.0,
                                  bottom: 18.0),
                              child: Text(
                                "Select folder",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: SizeHelper.getHeadline6,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.87)),
                              ),
                            ),
                            Flexible(
                                child: DeepScrollbar(
                              child: ScrollConfiguration(
                                behavior: DeepScrollBehavior(),
                                child: ListView.builder(
                                    cacheExtent: 100.0,
                                    itemCount:
                                        folderList.length + defaultItemValue,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: 18.0, right: 18.0, bottom: 8.0),
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Material(
                                          color: Colors.transparent,
                                          clipBehavior: Clip.hardEdge,
                                          shape: StadiumBorder(),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.of(context).pop();

                                              DeepDialog
                                                  .openCreateFolderMoveToDialog(
                                                      context: context,
                                                      currentFolder:
                                                          currentFolder,
                                                      drawerIndex: drawerIndex,
                                                      selectionProvider:
                                                          selectionProvider,
                                                      deepBottomProvider:
                                                          deepBottomProvider);
                                            },
                                            leading: Icon(
                                              MyIcon.plus,
                                              color: Colors.white70,
                                            ),
                                            title: Text(
                                              "New folder",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      color: Colors.white70,
                                                      fontSize: SizeHelper
                                                          .getModalButton),
                                            ),
                                          ),
                                        );
                                      } else if (currentFolder.isNotNull) {
                                        if (index == 1) {
                                          return Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            shape: StadiumBorder(),
                                            child: ListTile(
                                              onTap: () {
                                                NoteCreation.moveToFolderBatch(
                                                    context: context,
                                                    folder: null,
                                                    selectionProvider:
                                                        selectionProvider,
                                                    database: database);

                                                Navigator.of(context).pop();

                                                DeepToast.showToast(
                                                    description:
                                                        "Note moved successfully");

                                                deepBottomProvider
                                                    .setSelection = false;

                                                selectionProvider.setSelection =
                                                    false;

                                                selectionProvider.getSelected
                                                    .clear();
                                              },
                                              leading: Icon(
                                                Icons.folder_shared,
                                                color: Colors.white70,
                                              ),
                                              title: Text(
                                                "Main folder",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.white70,
                                                        fontSize: SizeHelper
                                                            .getModalButton),
                                              ),
                                            ),
                                          );
                                        } else if (currentFolder.id !=
                                            folderList[index - defaultItemValue]
                                                .id) {
                                          final folder = folderList[
                                              index - defaultItemValue];

                                          return Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            shape: StadiumBorder(),
                                            child: ListTile(
                                              onTap: () {
                                                NoteCreation.moveToFolderBatch(
                                                    context: context,
                                                    folder: folder,
                                                    selectionProvider:
                                                        selectionProvider,
                                                    database: database);

                                                Navigator.of(context).pop();

                                                DeepToast.showToast(
                                                    description:
                                                        "Note moved successfully");

                                                deepBottomProvider
                                                    .setSelection = false;

                                                selectionProvider.setSelection =
                                                    false;

                                                selectionProvider.getSelected
                                                    .clear();
                                              },
                                              leading: Icon(
                                                Icons.folder,
                                                color: Colors.white70,
                                              ),
                                              title: Text(
                                                "${folder.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.white70,
                                                        fontSize: SizeHelper
                                                            .getModalButton),
                                              ),
                                            ),
                                          );
                                        } else
                                          return const SizedBox();
                                      } else if (drawerIndex == 0) {
                                        if (index == 1) {
                                          return Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            shape: StadiumBorder(),
                                            child: ListTile(
                                              onTap: () {
                                                NoteCreation.moveToFolderBatch(
                                                    context: context,
                                                    folder: null,
                                                    selectionProvider:
                                                        selectionProvider,
                                                    database: database);

                                                Navigator.of(context).pop();

                                                DeepToast.showToast(
                                                    description:
                                                        "Note moved successfully");

                                                deepBottomProvider
                                                    .setSelection = false;

                                                selectionProvider.setSelection =
                                                    false;

                                                selectionProvider.getSelected
                                                    .clear();
                                              },
                                              leading: Icon(
                                                Icons.folder_shared,
                                                color: Colors.white70,
                                              ),
                                              title: Text(
                                                "Main folder",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.white70,
                                                        fontSize: SizeHelper
                                                            .getModalButton),
                                              ),
                                            ),
                                          );
                                        } else {
                                          final folder = folderList[
                                              index - defaultItemValue];

                                          return Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            shape: StadiumBorder(),
                                            child: ListTile(
                                              onTap: () {
                                                NoteCreation.moveToFolderBatch(
                                                    context: context,
                                                    folder: folder,
                                                    selectionProvider:
                                                        selectionProvider,
                                                    database: database);

                                                Navigator.of(context).pop();

                                                DeepToast.showToast(
                                                    description:
                                                        "Note moved successfully");

                                                deepBottomProvider
                                                    .setSelection = false;

                                                selectionProvider.setSelection =
                                                    false;

                                                selectionProvider.getSelected
                                                    .clear();
                                              },
                                              leading: Icon(
                                                Icons.folder,
                                                color: Colors.white70,
                                              ),
                                              title: Text(
                                                "${folder.name}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: Colors.white70,
                                                        fontSize: SizeHelper
                                                            .getModalButton),
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        final folder = folderList[
                                            index - defaultItemValue];

                                        return Material(
                                          color: Colors.transparent,
                                          clipBehavior: Clip.hardEdge,
                                          shape: StadiumBorder(),
                                          child: ListTile(
                                            onTap: () {
                                              NoteCreation.moveToFolderBatch(
                                                  context: context,
                                                  folder: folder,
                                                  selectionProvider:
                                                      selectionProvider,
                                                  database: database);

                                              Navigator.of(context).pop();

                                              DeepToast.showToast(
                                                  description:
                                                      "Note moved successfully");

                                              deepBottomProvider.setSelection =
                                                  false;

                                              selectionProvider.setSelection =
                                                  false;

                                              selectionProvider.getSelected
                                                  .clear();
                                            },
                                            leading: Icon(
                                              Icons.folder,
                                              color: Colors.white70,
                                            ),
                                            title: Text(
                                              "${folder.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      color: Colors.white70,
                                                      fontSize: SizeHelper
                                                          .getModalButton),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ))
                          ],
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
