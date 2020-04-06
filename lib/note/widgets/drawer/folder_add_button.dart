import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';

class _LocalStore {
  String _folderName = "";

  String get getFolderName => _folderName;

  set setFolderName(String folderName) => _folderName = folderName;
}

class FolderAddButton extends StatelessWidget {
  final _local = _LocalStore();

  FolderAddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          "FOLDERS",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white.withOpacity(0.70), fontSize: 16.0),
        ),
        trailing: FlatButton(
            shape: StadiumBorder(
                side: BorderSide(
                    color: Theme.of(context).accentColor, width: 2.0)),
            onPressed: () {
              _createFolderDialog(context: context);
            },
            child: Text(
              "ADD",
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
              ),
            )));
  }

  Future<void> _createFolderDialog({
    @required BuildContext context,
  }) {
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
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Create folder",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.87)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: Consumer<TextControllerProvider>(
                      builder: (context, textControllerProvider, child) {
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
                                    color: Colors.white70, fontSize: 16.0),
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              _local.setFolderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                          listen: false)
                                      .setIsNameTyped =
                                  !_local.getFolderName.isNullEmptyOrWhitespace;
                            },
                            decoration: InputDecoration(
                              focusColor: Theme.of(context).accentColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(width: 2.0)),
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
                            top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18.0,
                          ),
                        )),
                    Consumer<FolderDialogProvider>(
                        //selector: (context, provider) => provider.isNameTyped,
                        builder: (context, provider, widget) {
                      return FlatButton(
                          shape: StadiumBorder(),
                          color: Colors.grey[600].withOpacity(0.2),
                          textColor: Colors.blueAccent,
                          padding: EdgeInsets.only(
                              top: 16.0, bottom: 16.0, right: 48.0, left: 48.0),
                          onPressed: provider.isNameTyped
                              ? () => _addFolder(context: context)
                              : null,
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 18.0,
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

  Future<void> _addFolder({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    await database.folderNoteDao
        .insertFolder(FolderNoteCompanion(name: Value(_local.getFolderName)));

    Navigator.of(context).pop();
  }
}
