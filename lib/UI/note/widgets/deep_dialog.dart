import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/bussiness_logic/note/folder_creation.dart';
import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/text_controller_provider.dart';
import 'package:deep_paper/bussiness_logic/note/trash_management.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'deep_toast.dart';
import 'move_to_folder.dart';

class DeepDialog {
  static Future<void> openRestoreDialog(
      {@required BuildContext context, @required Note data}) {
    return showDialog(
      context: context,
      builder: (context) => ScrollConfiguration(
        behavior: DeepScrollBehavior(),
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: EdgeInsets.all(24.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                "Restore this note ?",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: SizeHelper.getModalDescription,
                    color: Colors.white.withOpacity(0.87)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    textColor: Colors.white.withOpacity(0.87),
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
                    textColor: Theme.of(context).accentColor,
                    onPressed: () async {
                      TrashManagement.restore(context: context, data: data);

                      DeepToast.showToast(
                          description: "Note restored successfully");

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
    return showDialog(
      context: context,
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
        child: ScrollConfiguration(
          behavior: DeepScrollBehavior(),
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.all(24.0),
            children: <Widget>[
              Text(
                "Create folder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: SizeHelper.getHeadline6,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.87)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 26.0, bottom: 26.0),
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
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context).accentColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      textColor: Colors.white.withOpacity(0.87),
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
                      builder: (context, provider, widget) {
                    return FlatButton(
                        textColor: Theme.of(context).accentColor,
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
    );
  }

  static Future<void> openCreateFolderMoveToDialog(
      {@required BuildContext context,
      @required FolderNoteData currentFolder,
      @required int drawerIndex,
      @required SelectionProvider selectionProvider,
      @required DeepBottomProvider deepBottomProvider,
      DeepPaperDatabase database}) {
    String folderName;

    return showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();

          MoveToFolder.openMoveToDialog(
              context: context,
              currentFolder: currentFolder,
              drawerIndex: drawerIndex,
              selectionProvider: selectionProvider,
              deepBottomProvider: deepBottomProvider,
              database: database);

          return true;
        },
        child: MultiProvider(
          providers: [
            Provider<TextControllerProvider>(
              create: (context) => TextControllerProvider(),
              dispose: (context, provider) => provider.controller.dispose(),
            ),
            ChangeNotifierProvider(create: (context) => FolderDialogProvider()),
            ChangeNotifierProvider(
                create: (context) => DetectTextDirectionProvider())
          ],
          child: ScrollConfiguration(
            behavior: DeepScrollBehavior(),
            child: SimpleDialog(
                contentPadding: EdgeInsets.all(24.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                children: <Widget>[
                  Text(
                    "Create folder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: SizeHelper.getHeadline6,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.87)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 26.0, bottom: 26.0),
                    child: Consumer<TextControllerProvider>(
                        builder: (context, textControllerProvider, child) {
                      return Selector<DetectTextDirectionProvider,
                              TextDirection>(
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

                                Provider.of<DetectTextDirectionProvider>(
                                        context,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          textColor: Colors.white.withOpacity(0.87),
                          onPressed: () {
                            Navigator.of(context).maybePop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: SizeHelper.getModalButton,
                            ),
                          )),
                      Consumer<FolderDialogProvider>(
                          builder: (context, provider, widget) {
                        return FlatButton(
                            textColor: Theme.of(context).accentColor,
                            onPressed: provider.isNameTyped
                                ? () {
                                    FolderCreation.create(
                                        context: context, name: folderName);

                                    Navigator.of(context).maybePop();
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
                ]),
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

    return showDialog(
      context: context,
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
        child: ScrollConfiguration(
          behavior: DeepScrollBehavior(),
          child: SimpleDialog(
              contentPadding: EdgeInsets.all(24.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              children: <Widget>[
                Text(
                  "Rename folder",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: SizeHelper.getHeadline6,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.87)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 26, bottom: 26),
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

                                  Provider
                                      .of<DetectTextDirectionProvider>(context,
                                      listen: false)
                                      .checkDirection = folderName;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                          width: 2.0,
                                          color: Theme
                                              .of(context)
                                              .accentColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide(
                                          width: 2.0,
                                          color: Theme
                                              .of(context)
                                              .accentColor)),
                                  hintText: 'Folder Name',
                                ),
                              );
                            });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        textColor: Colors.white.withOpacity(0.87),
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
                        builder: (context, provider, widget) {
                          return FlatButton(
                              textColor: Theme
                                  .of(context)
                                  .accentColor,
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
              ]),
        ),
      ),
    );
  }

  static Future<void> openDeleteFolderDialog({@required BuildContext context}) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return showDialog(
      context: context,
      builder: (context) => ScrollConfiguration(
        behavior: DeepScrollBehavior(),
        child: SimpleDialog(
            contentPadding: EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              "Delete folder",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: SizeHelper.getHeadline6,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.87)),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "Delete this folder and all notes inside this folder forever.",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: SizeHelper.getModalDescription,
                      color: Colors.white70),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      textColor: Colors.white.withOpacity(0.87),
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
                      textColor: Theme.of(context).accentColor,
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
            ]),
      ),
    );
  }
}
