import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class MoveToFolder {
  static Future openMoveToDialog(
      {@required BuildContext context,
      @required FolderNoteData currentFolder,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      @required DeepPaperDatabase database}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final int defaultItemValue = currentFolder.isNotNull ? 2 : 1;

    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              BottomModal.openCreateFolderMoveToDialog(
                  context: context,
                  currentFolder: currentFolder,
                  selectionProvider: selectionProvider,
                  deepBottomProvider: deepBottomProvider);

              return true;
            },
            child: FutureProvider(
              create: (context) => database.folderNoteDao.getFolder(),
              child: Consumer<List<FolderNoteData>>(
                builder: (context, folderList, widget) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  child: folderList.isNull
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsetsResponsive.only(
                              top: 26.0, bottom: 18.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Select folder",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: SizeHelper.getHeadline6,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.87)),
                              ),
                              Flexible(
                                  child: ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      itemCount:
                                          folderList.length + defaultItemValue,
                                      shrinkWrap: true,
                                      padding: EdgeInsetsResponsive.all(18),
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.hardEdge,
                                            shape: StadiumBorder(),
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.of(context).pop();

                                                BottomModal
                                                    .openCreateFolderMoveToDialog(
                                                        context: context,
                                                        currentFolder:
                                                            currentFolder,
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
                                                  NoteCreation
                                                      .moveToFolderBatch(
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

                                                  selectionProvider
                                                      .setSelection = false;

                                                  selectionProvider.getSelected
                                                      .clear();
                                                },
                                                leading: Icon(
                                                  Icons.home,
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
                                              folderList[
                                                      index - defaultItemValue]
                                                  .id) {
                                            final folder = folderList[
                                                index - defaultItemValue];

                                            return Material(
                                              color: Colors.transparent,
                                              clipBehavior: Clip.hardEdge,
                                              shape: StadiumBorder(),
                                              child: ListTile(
                                                onTap: () {
                                                  NoteCreation
                                                      .moveToFolderBatch(
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

                                                  selectionProvider
                                                      .setSelection = false;

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
                                      }))
                            ],
                          ),
                        ),
                ),
              ),
            ),
          );
        });
  }
}
