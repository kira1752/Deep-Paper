import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/folder_creation.dart';
import '../../../../business_logic/note/provider/detect_text_direction_provider.dart';
import '../../../../business_logic/note/provider/folder_dialog_provider.dart';
import '../../../../business_logic/note/provider/note_drawer_provider.dart';
import '../../../../business_logic/note/provider/text_controller_provider.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../widgets/deep_base_dialog.dart';

class RenameFolderDialog extends StatefulWidget {
  final NoteDrawerProvider drawerProvider;

  const RenameFolderDialog({@required this.drawerProvider});

  @override
  _RenameFolderDialogState createState() => _RenameFolderDialogState();
}

class _RenameFolderDialogState extends State<RenameFolderDialog> {
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
    return DeepBaseDialog(
      childrenPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Text(
            'Rename folder',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: SizeHelper.getHeadline6,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.87)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<TextControllerProvider>(
              builder: (context, textControllerProvider, _) {
            textControllerProvider.controller.text = folderName;

            textControllerProvider.controller.selection =
                TextSelection(baseOffset: 0, extentOffset: folderName.length);

            Provider.of<DetectTextDirectionProvider>(context, listen: false)
                .checkDirection = folderName;

            return Selector<DetectTextDirectionProvider, TextDirection>(
                selector: (context, provider) => provider.getDirection
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                builder: (context, direction, _) => TextField(
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
                            !folderName.isNullEmptyOrWhitespace &&
                                folderName != drawerProvider.getFolder.name;

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
                    ));
          }),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
              border:
                  Border(top: Divider.createBorderSide(context, width: 1.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textColor: Colors.white.withOpacity(0.87),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0))),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: Divider.createBorderSide(context, width: 1.0))),
                  child: Consumer<FolderDialogProvider>(
                    builder: (context, provider, renameText) =>
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
                              FolderCreation.update(
                                  drawerProvider: drawerProvider,
                                  name: folderName);

                              Get.back();
                            }
                                : null,
                            child: renameText),
                    child: Text(
                      'Rename',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeHelper.getModalButton,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
