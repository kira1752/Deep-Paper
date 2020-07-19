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
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

import 'deep_toast.dart';
import 'move_to_folder.dart';

class DeepDialog {
  static Future<void> openRestoreDialog(
      {@required BuildContext context, @required Note data}) {
    return showDialog(
        context: context, builder: (context) => _RestoreDialog(data: data));
  }

  static Future<void> openCreateFolderDialog({
    @required BuildContext context,
  }) {
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
        child: DeepBaseDialog(child: _CreateFolderDialog()),
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
          child: DeepBaseDialog(child: _CreateFolderMoveToDialog()),
        ),
      ),
    );
  }

  static Future<void> openRenameFolderDialog({
    @required BuildContext context,
  }) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

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
        child: DeepBaseDialog(
            child: _RenameFolderDialog(
          drawerProvider: drawerProvider,
        )),
      ),
    );
  }

  static Future<void> openDeleteFolderDialog({@required BuildContext context}) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) => _DeleteFolderDialog(
              drawerProvider: drawerProvider,
            ));
  }

  static Future<void> openNoteInfo(
      {@required BuildContext context,
      @required String folderName,
      @required DateTime created,
      @required DateTime modified}) {
    return showDialog(
        context: context,
        builder: (context) => _NoteInfoDialog(
              folderName: folderName,
          created: created,
          modified: modified,
            ));
  }
}

class DeepBaseDialog extends StatelessWidget {
  final Widget child;

  DeepBaseDialog({this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(12.0))),
      insetAnimationDuration: Duration(milliseconds: 250),
      insetAnimationCurve: Curves.easeIn,
      child: child,
    );
  }
}

class _NoteInfoDialog extends StatelessWidget {
  final String folderName;
  final DateTime modified;
  final DateTime created;

  _NoteInfoDialog({@required this.folderName,
    @required this.modified,
    @required this.created});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(12.0))),
        contentPadding: const EdgeInsets.all(24.0),
        actionsPadding:
            const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12.0),
        titlePadding: const EdgeInsets.all(0.0),
        title: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 3.0,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.50)))),
          child: Text(
            "Note Info",
            textAlign: TextAlign.center,
            style: Theme
                .of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: SizeHelper.getTitle),
          ),
        ),
        actions: <Widget>[
          FlatButton(
              textColor: Theme
                  .of(context)
                  .accentColor
                  .withOpacity(0.87),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(12.0))),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: SizeHelper.getModalButton,
                ),
              )),
        ],
        content: SingleChildScrollView(
            child: ListBody(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Folder",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getBodyText1),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                      child: Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: SizeHelper.getBodyText1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "$folderName",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getBodyText1),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Created",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getBodyText1),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                      child: Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: SizeHelper.getBodyText1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "${DateFormat.yMMMd("en_US").add_jm().format(created)}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getBodyText1),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Modified",
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: SizeHelper.getBodyText1),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                    child: Text(
                      ":",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getBodyText1),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "${DateFormat.yMMMd("en_US").add_jm().format(modified)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: SizeHelper.getBodyText1),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}

class _RestoreDialog extends StatelessWidget {
  final Note data;

  _RestoreDialog({@required this.data});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DeepScrollBehavior(),
      child: SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(12.0))),
        contentPadding: const EdgeInsets.all(24.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
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
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(12.0))),
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
                  textColor: Theme
                      .of(context)
                      .accentColor
                      .withOpacity(0.87),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      const BorderRadius.all(const Radius.circular(12.0))),
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
    );
  }
}

class _DeleteFolderDialog extends StatefulWidget {
  final NoteDrawerProvider drawerProvider;

  _DeleteFolderDialog({@required this.drawerProvider});

  @override
  __DeleteFolderDialogState createState() => __DeleteFolderDialogState();
}

class __DeleteFolderDialogState extends State<_DeleteFolderDialog> {
  NoteDrawerProvider drawerProvider;

  @override
  void initState() {
    super.initState();

    drawerProvider = widget.drawerProvider;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DeepScrollBehavior(),
      child: SimpleDialog(
          contentPadding: const EdgeInsets.all(24.0),
          shape: RoundedRectangleBorder(
              borderRadius:
              const BorderRadius.all(const Radius.circular(12.0))),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                "Delete this folder ?\n\nAll notes inside this folder will be deleted.",
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
                    shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(12.0))),
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
                    textColor: Theme
                        .of(context)
                        .accentColor
                        .withOpacity(0.87),
                    shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(12.0))),
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
    );
  }
}

class _CreateFolderDialog extends StatefulWidget {
  @override
  __CreateFolderDialogState createState() => __CreateFolderDialogState();
}

class __CreateFolderDialogState extends State<_CreateFolderDialog> {
  String folderName;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
                child: ScrollConfiguration(
                  behavior: DeepScrollBehavior(),
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: ListBody(
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
                            padding: const EdgeInsets.only(
                                top: 26.0, bottom: 26.0),
                            child: Consumer<TextControllerProvider>(
                                builder: (context, textControllerProvider,
                                    child) {
                                  return Selector<DetectTextDirectionProvider,
                                      TextDirection>(
                                      selector: (context, provider) =>
                                      provider.getDirection
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      builder: (context, direction, child) {
                                        return TextField(
                                          controller: textControllerProvider
                                              .controller,
                                          textDirection: direction,
                                          autofocus: true,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                              color: Colors.white70,
                                              fontSize:
                                              SizeHelper.getModalTextField),
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) {
                                            folderName = value;
                                            Provider
                                                .of<FolderDialogProvider>(
                                                context,
                                                listen: false)
                                                .setIsNameTyped =
                                            !folderName.isNullEmptyOrWhitespace;

                                            Provider
                                                .of<
                                                DetectTextDirectionProvider>(
                                                context,
                                                listen: false)
                                                .checkDirection = folderName;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color:
                                                    Theme
                                                        .of(context)
                                                        .accentColor)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color:
                                                    Theme
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(12.0))),
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
                                            .accentColor
                                            .withOpacity(0.87),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: const BorderRadius
                                                .all(
                                                const Radius.circular(12.0))),
                                        onPressed: provider.isNameTyped
                                            ? () {
                                          FolderCreation.create(
                                              context: context,
                                              name: folderName);

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
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

class _CreateFolderMoveToDialog extends StatefulWidget {
  @override
  __CreateFolderMoveToDialogState createState() =>
      __CreateFolderMoveToDialogState();
}

class __CreateFolderMoveToDialogState extends State<_CreateFolderMoveToDialog> {
  String folderName;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ScrollConfiguration(
                behavior: DeepScrollBehavior(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: ListBody(
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
                        padding: const EdgeInsets.only(top: 26.0, bottom: 26.0),
                        child: Consumer<TextControllerProvider>(
                            builder: (context, textControllerProvider, child) {
                              return Selector<DetectTextDirectionProvider,
                                  TextDirection>(
                                  selector: (context, provider) =>
                                  provider.getDirection
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  builder: (context, direction, child) {
                                    return TextField(
                                      controller: textControllerProvider
                                          .controller,
                                      textDirection: direction,
                                      autofocus: true,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                          color: Colors.white70,
                                          fontSize:
                                          SizeHelper.getModalTextField),
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        folderName = value;
                                        Provider
                                            .of<FolderDialogProvider>(context,
                                            listen: false)
                                            .setIsNameTyped =
                                        !folderName.isNullEmptyOrWhitespace;

                                        Provider
                                            .of<DetectTextDirectionProvider>(
                                            context,
                                            listen: false)
                                            .checkDirection = folderName;
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color:
                                                Theme
                                                    .of(context)
                                                    .accentColor)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color:
                                                Theme
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(12.0))),
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
                                    textColor: Theme
                                        .of(context)
                                        .accentColor
                                        .withOpacity(0.87),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(12.0))),
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RenameFolderDialog extends StatefulWidget {
  final NoteDrawerProvider drawerProvider;

  _RenameFolderDialog({@required this.drawerProvider});

  @override
  __RenameFolderDialogState createState() => __RenameFolderDialogState();
}

class __RenameFolderDialogState extends State<_RenameFolderDialog> {
  String folderName;
  NoteDrawerProvider drawerProvider;

  @override
  void initState() {
    super.initState();

    drawerProvider = widget.drawerProvider;
    folderName = drawerProvider.getFolder.name;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: ScrollConfiguration(
                  behavior: DeepScrollBehavior(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: ListBody(
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
                          padding: const EdgeInsets.only(top: 26, bottom: 26),
                          child: Consumer<TextControllerProvider>(builder:
                              (context, textControllerProvider, child) {
                            textControllerProvider.controller.text = folderName;

                            textControllerProvider.controller.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: folderName.length);

                            Provider
                                .of<DetectTextDirectionProvider>(context,
                                listen: false)
                                .checkDirection = folderName;

                            return Selector<DetectTextDirectionProvider,
                                TextDirection>(
                                selector: (context, provider) =>
                                provider.getDirection
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                builder: (context, direction, child) {
                                  return TextField(
                                    controller:
                                    textControllerProvider.controller,
                                    textDirection: direction,
                                    autofocus: true,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                        color: Colors.white70,
                                        fontSize:
                                        SizeHelper.getModalTextField),
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      folderName = value;
                                      Provider
                                          .of<FolderDialogProvider>(context,
                                          listen: false)
                                          .setIsNameTyped =
                                          !folderName.isNullEmptyOrWhitespace &&
                                              folderName !=
                                                  drawerProvider.getFolder.name;

                                      Provider
                                          .of<DetectTextDirectionProvider>(
                                          context,
                                          listen: false)
                                          .checkDirection = folderName;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                              width: 2.0,
                                              color: Theme
                                                  .of(context)
                                                  .accentColor)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12.0),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(12.0))),
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
                                          .accentColor
                                          .withOpacity(0.87),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(12.0))),
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
              )
            ]),
      ),
    );
  }
}
