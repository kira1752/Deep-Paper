import 'package:deep_paper/note/data/deep.dart';
import 'package:deep_paper/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/note/provider/text_controller_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:moor/moor.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

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
          textScaleFactor: MediaQuery.textScaleFactorOf(context),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white.withOpacity(0.70),
              fontSize: SizeHelper.getBodyText1),
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
              textScaleFactor: MediaQuery.textScaleFactorOf(context),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontSize: SizeHelper.getButton),
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
                              _local.setFolderName = value;
                              Provider.of<FolderDialogProvider>(context,
                                          listen: false)
                                      .setIsNameTyped =
                                  !_local.getFolderName.isNullEmptyOrWhitespace;

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
                              ? () => _addFolder(context: context)
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

  Future<void> _addFolder({@required BuildContext context}) async {
    final database = Provider.of<DeepPaperDatabase>(context, listen: false);

    final name = _local.getFolderName;
    final nameDirection = Bidi.detectRtlDirectionality(name)
        ? TextDirection.rtl
        : TextDirection.ltr;

    await database.folderNoteDao.insertFolder(FolderNoteCompanion(
        name: Value(name), nameDirection: Value(nameDirection)));

    Navigator.of(context).pop();
  }
}
