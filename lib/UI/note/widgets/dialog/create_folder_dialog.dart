import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/folder_creation.dart'
    as folder_creation;
import '../../../../business_logic/provider/note/detect_text_direction_provider.dart';
import '../../../../business_logic/provider/note/folder_dialog_provider.dart';
import '../../../../business_logic/provider/text_controller_provider.dart';
import '../../../../data/deep.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';
import '../../../widgets/deep_base_dialog.dart';

class CreateFolderDialog extends StatefulWidget {
  const CreateFolderDialog();

  @override
  _CreateFolderDialogState createState() => _CreateFolderDialogState();
}

class _CreateFolderDialogState extends State<CreateFolderDialog> {
  String folderName;

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(childrenPadding: EdgeInsets.zero, children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
        child: Text(
          'Create folder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeHelper.headline6,
            fontWeight: FontWeight.w600,
            color: themeColorOpacity(context: context, opacity: .87),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<TextControllerProvider>(
            builder: (context, textControllerProvider, _) =>
                Selector<DetectTextDirectionProvider, TextDirection>(
                    selector: (context, provider) => provider.getDirection
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    builder: (context, direction, _) => TextField(
                      controller: textControllerProvider.controller,
                          textDirection: direction,
                          autofocus: true,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: themeColorOpacity(
                                  context: context, opacity: .7),
                              fontSize: SizeHelper.modalTextField),
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
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.80))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.80))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.80))),
                            labelText: 'Folder Name',
                          ),
                        ))),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
            border: Border(top: Divider.createBorderSide(context))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textColor: themeColorOpacity(context: context, opacity: .87),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12.0))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: SizeHelper.modalButton,
                    ),
                  )),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border(left: Divider.createBorderSide(context))),
                child: Consumer<FolderDialogProvider>(
                  builder: (context, provider, createText) =>
                      FlatButton(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          textColor:
                          Theme
                              .of(context)
                              .accentColor
                              .withOpacity(0.87),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12.0))),
                          onPressed: provider.isNameTyped
                              ? () {
                              final database = Provider.of<DeepPaperDatabase>(
                                  context,
                                  listen: false);
                              folder_creation.create(
                                  name: folderName, database: database);

                              Navigator.pop(context);
                            }
                          : null,
                      child: createText),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: SizeHelper.modalButton,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
