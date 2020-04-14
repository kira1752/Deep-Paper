import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/note/widgets/deep_toast.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:deep_paper/utility/extension.dart';

class _LocalStore {
  String _folderName = "";

  String get getFolderName => _folderName;

  set setFolderName(String folderName) => _folderName = folderName;
}

class FolderMenu extends StatelessWidget {
  final _local = _LocalStore();

  @override
  Widget build(BuildContext context) {
    return Selector<NoteDrawerProvider, bool>(
      selector: (context, provider) =>
          provider.getIndexFolderItem != null &&
          provider.getIndexDrawerItem == null,
      builder: (context, showMenu, child) {
        debugPrintSynchronously("Folder Menu rebuild");
        return Visibility(
          visible: showMenu,
          child: PopupMenuButton(
              onSelected: (choice) {
                _onFolderMenuSelected(context: context, choice: choice);
              },
              tooltip: "Open Folder Menu",
              padding: EdgeInsets.fromLTRB(
                  SizeHelper.setWidth(size: 18),
                  SizeHelper.setHeight(size: 18),
                  SizeHelper.setWidth(size: 18),
                  SizeHelper.setHeight(size: 18)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 0,
                        child: ListTile(
                          leading: Icon(
                            MyIcon.edit_outline,
                            color: Colors.white.withOpacity(0.60),
                          ),
                          title: Text(
                            "Rename Folder",
                            style: TextStyle(fontSize: SizeHelper.getBodyText1),
                          ),
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: Icon(MyIcon.trash_empty,
                              color: Colors.white.withOpacity(0.60)),
                          title: Text(
                            "Delete Folder",
                            style: TextStyle(fontSize: SizeHelper.getBodyText1),
                          ),
                        )),
                  ]),
        );
      },
    );
  }

  void _onFolderMenuSelected(
      {@required BuildContext context, @required int choice}) async {
    switch (choice) {
      case 0:
        await _renameFolderDialog(context: context);
        break;
      case 1:
        await _deleteFolderDialog(context: context);
        break;
      default:
    }
  }

  Future<void> _renameFolderDialog({
    @required BuildContext context,
  }) {
    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    _local.setFolderName = drawerProvider.getFolder.name;

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
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
          duration: Duration(milliseconds: 300),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                SizeHelper.setWidth(size: 26),
                SizeHelper.setHeight(size: 26),
                SizeHelper.setWidth(size: 26),
                SizeHelper.setHeight(size: 26)),
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
                  padding: EdgeInsets.only(
                      top: SizeHelper.setHeight(size: 26),
                      bottom: SizeHelper.setHeight(size: 26)),
                  child: Consumer<TextControllerProvider>(
                      builder: (context, textControllerProvider, child) {
                    textControllerProvider.controller.text =
                        _local.getFolderName;

                    textControllerProvider.controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _local.getFolderName.length);

                    Provider.of<DetectTextDirectionProvider>(context,
                            listen: false)
                        .checkDirection = _local.getFolderName;

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
                              _local.setFolderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                      listen: false)
                                  .setIsNameTyped = !_local
                                      .getFolderName.isNullEmptyOrWhitespace &&
                                  _local.getFolderName !=
                                      drawerProvider.getFolder.name;

                              Provider.of<DetectTextDirectionProvider>(context,
                                      listen: false)
                                  .checkDirection = _local.getFolderName;
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
                        padding: EdgeInsets.only(
                            top: SizeHelper.setHeight(size: 16.0),
                            bottom: SizeHelper.setHeight(size: 16.0),
                            right: SizeHelper.setWidth(size: 48.0),
                            left: SizeHelper.setWidth(size: 48.0)),
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
                          padding: EdgeInsets.only(
                              top: SizeHelper.setHeight(size: 16.0),
                              bottom: SizeHelper.setHeight(size: 16.0),
                              right: SizeHelper.setWidth(size: 48.0),
                              left: SizeHelper.setWidth(size: 48.0)),
                          onPressed: provider.isNameTyped
                              ? () => _renameFolder(
                                  context: context,
                                  drawerProvider: drawerProvider)
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

  Future<void> _renameFolder(
      {@required BuildContext context,
      @required NoteDrawerProvider drawerProvider}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final name = _local.getFolderName;
    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    await database.folderNoteDao.updateFolder(drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection));

    drawerProvider.setTitleFragment = "$name";
    drawerProvider.setFolder = drawerProvider.getFolder
        .copyWith(name: name, nameDirection: nameDirection);

    Navigator.of(context).pop();
  }

  Future<void> _deleteFolderDialog({@required BuildContext context}) {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final drawerProvider =
        Provider.of<NoteDrawerProvider>(context, listen: false);

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            SizeHelper.setWidth(size: 26),
            SizeHelper.setHeight(size: 26),
            SizeHelper.setWidth(size: 26),
            SizeHelper.setHeight(size: 26)),
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
              padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
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
                    padding: EdgeInsets.only(
                        top: SizeHelper.setHeight(size: 16.0),
                        bottom: SizeHelper.setHeight(size: 16.0),
                        right: SizeHelper.setWidth(size: 48.0),
                        left: SizeHelper.setWidth(size: 48.0)),
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
                    padding: EdgeInsets.only(
                        top: SizeHelper.setHeight(size: 16.0),
                        bottom: SizeHelper.setHeight(size: 16.0),
                        right: SizeHelper.setWidth(size: 48.0),
                        left: SizeHelper.setWidth(size: 48.0)),
                    onPressed: () async {
                      await database.noteDao
                          .deleteFolderRelationWhenNoteInTrash(
                              drawerProvider.getFolder);

                      await database.noteDao.deleteNotesInsideFolderForever(
                          drawerProvider.getFolder);

                      await database.folderNoteDao
                          .deleteFolder(drawerProvider.getFolder);

                      drawerProvider.setFolderState = false;
                      drawerProvider.setIndexFolderItem = null;
                      drawerProvider.setFolder = null;
                      drawerProvider.setIndexDrawerItem = 0;
                      drawerProvider.setTitleFragment = "NOTE";

                      Navigator.of(context).pop();

                      DeepToast.showToast(
                          description: "Folder deleted successfully");
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
