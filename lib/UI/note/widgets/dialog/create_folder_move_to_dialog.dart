import 'package:deep_paper/UI/widgets/deep_base_dialog.dart';
import 'package:deep_paper/business_logic/note/folder_creation.dart';
import 'package:deep_paper/business_logic/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/business_logic/note/provider/folder_dialog_provider.dart';
import 'package:deep_paper/business_logic/note/provider/text_controller_provider.dart';
import 'package:deep_paper/utility/extension.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFolderMoveToDialog extends StatefulWidget {
  @override
  _CreateFolderMoveToDialogState createState() =>
      _CreateFolderMoveToDialogState();
}

class _CreateFolderMoveToDialogState extends State<CreateFolderMoveToDialog> {
  String folderName;

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      childrenPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Text(
            'Create folder',
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
                      Provider.of<FolderDialogProvider>(context, listen: false)
                          .setIsNameTyped = !folderName.isNullEmptyOrWhitespace;

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
                  );
                });
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
                      Navigator.of(context).maybePop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: SizeHelper.getModalButton,
                      ),
                    )),
              ),
              Consumer<FolderDialogProvider>(
                  builder: (context, provider, widget) {
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left:
                                Divider.createBorderSide(context, width: 1.0))),
                    child: FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textColor:
                            Theme.of(context).accentColor.withOpacity(0.87),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.0))),
                        onPressed: provider.isNameTyped
                            ? () {
                                FolderCreation.create(
                                    context: context, name: folderName);

                                Navigator.of(context).maybePop();
                              }
                            : null,
                        child: Text(
                          'Create',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: SizeHelper.getModalButton,
                          ),
                        )),
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
