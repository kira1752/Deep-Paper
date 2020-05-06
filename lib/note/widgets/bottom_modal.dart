import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/folder_creation.dart';
import 'package:deep_paper/note/business_logic/trash_management.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/note/widgets/move_to_folder.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:deep_paper/utility/extension.dart';

class BottomModal {
  static Future openAddMenu({@required BuildContext context}) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        builder: (context) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsetsResponsive.all(18.0),
            children: <Widget>[
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    MyIcon.camera_alt_outline,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Take photo",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    MyIcon.photo_outline,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Choose image",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.mic_none,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Recording",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    MyIcon.audiotrack_outline,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Choose audio",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              )
            ],
          );
        });
  }

  static Future openOptionsMenu(
      {@required BuildContext context,
      @required bool newNote,
      @required void Function() onDelete,
      @required void Function() onCopy}) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        builder: (context) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsetsResponsive.all(18.0),
            children: <Widget>[
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  enabled: newNote ? false : true,
                  onTap: onDelete,
                  leading: Icon(
                    MyIcon.trash_empty,
                    color: newNote ? Colors.white30 : Colors.white70,
                  ),
                  title: Text(
                    "Delete",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: newNote ? Colors.white30 : Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  enabled: newNote ? false : true,
                  onTap: onCopy,
                  leading: Icon(
                    Icons.content_copy,
                    color: newNote ? Colors.white30 : Colors.white70,
                  ),
                  title: Text(
                    "Make a copy",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: newNote ? Colors.white30 : Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                clipBehavior: Clip.hardEdge,
                shape: StadiumBorder(),
                child: ListTile(
                  leading: Icon(
                    Icons.color_lens,
                    color: Colors.white70,
                  ),
                  title: Text(
                    "Change color",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white70,
                        fontSize: SizeHelper.getModalButton),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> openRestoreDialog(
      {@required BuildContext context, @required Note data}) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => Padding(
        padding: EdgeInsetsResponsive.all(26.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Restore note",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: SizeHelper.getHeadline6,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.87)),
            ),
            Padding(
              padding: EdgeInsetsResponsive.only(top: 24.0, bottom: 24.0),
              child: Text(
                "Couldn't open this note. Restore this note to edit the content.",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: SizeHelper.getModalDescription,
                    color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Colors.white.withOpacity(0.87),
                    padding: EdgeInsetsResponsive.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Theme.of(context).accentColor,
                    padding: EdgeInsetsResponsive.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () async {
                      TrashManagement.restore(context: context, data: data);

                      DeepToast.showToast(
                          description: "Trash emptied successfully");

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Restore",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future<void> openCreateFolderDialog({
    @required BuildContext context,
  }) {
    String folderName;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => MultiProvider(
        providers: [
          Provider<TextControllerProvider>(
            create: (context) => TextControllerProvider(),
            dispose: (context, provider) => provider.controller.dispose(),
          ),
          ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
          ChangeNotifierProvider(
              create: (context) => DetectTextDirectionProvider())
        ],
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: EdgeInsetsResponsive.all(26.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Create folder",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: SizeHelper.getHeadline6,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.87)),
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(top: 26.0, bottom: 26.0),
                  child: Consumer<TextControllerProvider>(
                      builder: (context, textControllerProvider, child) {
                    return Selector<DetectTextDirectionProvider, TextDirection>(
                        selector: (context, provider) => provider.getDirection
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        builder: (context, direction, child) {
                          return TextField(
                            controller: textControllerProvider.controller,
                            textDirection: direction,
                            autofocus: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.white70,
                                    fontSize: SizeHelper.getModalTextField),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              folderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                          listen: false)
                                      .setIsNameTyped =
                                  !folderName.isNullEmptyOrWhitespace;

                              Provider.of<DetectTextDirectionProvider>(context,
                                      listen: false)
                                  .checkDirection = folderName;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              hintText: 'Folder Name',
                            ),
                          );
                        });
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.grey[600].withOpacity(0.2),
                        textColor: Colors.white.withOpacity(0.87),
                        padding: EdgeInsetsResponsive.only(
                            top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: SizeHelper.getModalButton,
                          ),
                        )),
                    Consumer<FolderDialogProvider>(
                        //selector: (context, provider) => provider.isNameTyped,
                        builder: (context, provider, widget) {
                      return FlatButton(
                          shape: StadiumBorder(),
                          color: Colors.grey[600].withOpacity(0.2),
                          textColor: Theme.of(context).accentColor,
                          padding: EdgeInsetsResponsive.only(
                              top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                          onPressed: provider.isNameTyped
                              ? () {
                                  FolderCreation.create(
                                      context: context, name: folderName);

                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: SizeHelper.getModalButton,
                            ),
                          ));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> openCreateFolderMoveToDialog(
      {@required BuildContext context,
      @required FolderNoteData currentFolder,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      DeepPaperDatabase database}) {
    String folderName;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => MultiProvider(
        providers: [
          Provider<TextControllerProvider>(
            create: (context) => TextControllerProvider(),
            dispose: (context, provider) => provider.controller.dispose(),
          ),
          ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
          ChangeNotifierProvider(
              create: (context) => DetectTextDirectionProvider())
        ],
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: EdgeInsetsResponsive.all(26.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Create folder",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: SizeHelper.getHeadline6,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.87)),
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(top: 26.0, bottom: 26.0),
                  child: Consumer<TextControllerProvider>(
                      builder: (context, textControllerProvider, child) {
                    return Selector<DetectTextDirectionProvider, TextDirection>(
                        selector: (context, provider) => provider.getDirection
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        builder: (context, direction, child) {
                          return TextField(
                            controller: textControllerProvider.controller,
                            textDirection: direction,
                            autofocus: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.white70,
                                    fontSize: SizeHelper.getModalTextField),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              folderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                          listen: false)
                                      .setIsNameTyped =
                                  !folderName.isNullEmptyOrWhitespace;

                              Provider.of<DetectTextDirectionProvider>(context,
                                      listen: false)
                                  .checkDirection = folderName;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              hintText: 'Folder Name',
                            ),
                          );
                        });
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.grey[600].withOpacity(0.2),
                        textColor: Colors.white.withOpacity(0.87),
                        padding: EdgeInsetsResponsive.only(
                            top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                        onPressed: () {
                          Navigator.of(context).pop();

                          MoveToFolder.openMoveToDialog(
                              context: context,
                              currentFolder: currentFolder,
                              selectionProvider: selectionProvider,
                              deepBottomProvider: deepBottomProvider,
                              database: database);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: SizeHelper.getModalButton,
                          ),
                        )),
                    Consumer<FolderDialogProvider>(
                        //selector: (context, provider) => provider.isNameTyped,
                        builder: (context, provider, widget) {
                      return FlatButton(
                          shape: StadiumBorder(),
                          color: Colors.grey[600].withOpacity(0.2),
                          textColor: Theme.of(context).accentColor,
                          padding: EdgeInsetsResponsive.only(
                              top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                          onPressed: provider.isNameTyped
                              ? () {
                                  FolderCreation.create(
                                      context: context, name: folderName);

                                  Navigator.of(context).pop();

                                  MoveToFolder.openMoveToDialog(
                                      context: context,
                                      currentFolder: currentFolder,
                                      selectionProvider: selectionProvider,
                                      deepBottomProvider: deepBottomProvider,
                                      database: database);
                                }
                              : null,
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: SizeHelper.getModalButton,
                            ),
                          ));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> openRenameFolderDialog({
    @required BuildContext context,
  }) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    String folderName = drawerProvider.getFolder.name;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => MultiProvider(
        providers: [
          Provider<TextControllerProvider>(
            create: (context) => TextControllerProvider(),
            dispose: (context, provider) => provider.controller.dispose(),
          ),
          ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
          ChangeNotifierProvider(
              create: (context) => DetectTextDirectionProvider())
        ],
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: EdgeInsetsResponsive.all(26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Rename folder",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: SizeHelper.getHeadline6,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.87)),
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(top: 26, bottom: 26),
                  child: Consumer<TextControllerProvider>(
                      builder: (context, textControllerProvider, child) {
                    textControllerProvider.controller.text = folderName;

                    textControllerProvider.controller.selection = TextSelection(
                        baseOffset: 0, extentOffset: folderName.length);

                    Provider.of<DetectTextDirectionProvider>(context,
                            listen: false)
                        .checkDirection = folderName;

                    return Selector<DetectTextDirectionProvider, TextDirection>(
                        selector: (context, provider) => provider.getDirection
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        builder: (context, direction, child) {
                          return TextField(
                            controller: textControllerProvider.controller,
                            textDirection: direction,
                            autofocus: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Colors.white70,
                                    fontSize: SizeHelper.getModalTextField),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              folderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                      listen: false)
                                  .setIsNameTyped = !folderName
                                      .isNullEmptyOrWhitespace &&
                                  folderName != drawerProvider.getFolder.name;

                              Provider.of<DetectTextDirectionProvider>(context,
                                      listen: false)
                                  .checkDirection = folderName;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Theme.of(context).accentColor)),
                              hintText: 'Folder Name',
                            ),
                          );
                        });
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.grey[600].withOpacity(0.2),
                        textColor: Colors.white.withOpacity(0.87),
                        padding: EdgeInsetsResponsive.only(
                            top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: SizeHelper.getModalButton,
                          ),
                        )),
                    Consumer<FolderDialogProvider>(
                        //selector: (context, provider) => provider.isNameTyped,
                        builder: (context, provider, widget) {
                      return FlatButton(
                          shape: StadiumBorder(),
                          color: Colors.grey[600].withOpacity(0.2),
                          textColor: Theme.of(context).accentColor,
                          padding: EdgeInsetsResponsive.only(
                              top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                          onPressed: provider.isNameTyped
                              ? () {
                                  FolderCreation.update(
                                      context: context,
                                      drawerProvider: drawerProvider,
                                      name: folderName);

                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: Text(
                            "Rename",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: SizeHelper.getModalButton,
                            ),
                          ));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> openDeleteFolderDialog({@required BuildContext context}) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => Padding(
        padding: EdgeInsetsResponsive.all(26.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Delete folder",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: SizeHelper.getHeadline6,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.87)),
            ),
            Padding(
              padding: EdgeInsetsResponsive.only(top: 24.0, bottom: 24.0),
              child: Text(
                "Delete this folder and all notes inside this folder forever.",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: SizeHelper.getModalDescription,
                    color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Colors.white.withOpacity(0.87),
                    padding: EdgeInsetsResponsive.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.grey[600].withOpacity(0.2),
                    textColor: Theme.of(context).accentColor,
                    padding: EdgeInsetsResponsive.only(
                        top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                    onPressed: () {
                      FolderCreation.delete(
                          context: context, drawerProvider: drawerProvider);

                      DeepToast.showToast(
                          description: "Folder deleted successfully");

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
