import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_base_dialog.dart';

class NoteInfoDialog extends StatelessWidget {
  final String folderName;
  final DateTime modified;
  final DateTime created;

  const NoteInfoDialog(
      {@required this.folderName,
      @required this.modified,
      @required this.created});

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      titlePadding: const EdgeInsets.all(0.0),
      actionsPadding: 24.0,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(bottom: Divider.createBorderSide(context))),
        child: Text(
          'Note Info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeHelper.headline6,
            fontWeight: FontWeight.w600,
            color: themeColorOpacity(context: context, opacity: .87),
          ),
        ),
      ),
      actions: <Widget>[
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: Theme.of(context).accentColor.withOpacity(0.87),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0))),
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: SizeHelper.modalButton,
                ),
              )),
        ),
      ],
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
                  'Folder',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.bodyText1),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                  child: Text(
                    ':',
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(
                        color: themeColorOpacity(context: context, opacity: .7),
                        fontSize: SizeHelper.bodyText1),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  '$folderName',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.bodyText1),
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
                  'Created',
                  textAlign: TextAlign.right,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.bodyText1),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                  child: Text(
                    ':',
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(
                        color: themeColorOpacity(context: context, opacity: .7),
                        fontSize: SizeHelper.bodyText1),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  "${intl.DateFormat.yMMMd("en_US").add_jm().format(created)}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.bodyText1),
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
                'Modified',
                textAlign: TextAlign.right,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.bodyText1),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 24.0),
                child: Text(
                  ':',
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                      color: themeColorOpacity(context: context, opacity: .7),
                      fontSize: SizeHelper.bodyText1),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                "${intl.DateFormat.yMMMd("en_US").add_jm().format(modified)}",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.bodyText1),
              ),
            )
          ],
        ),
      ],
    );
  }
}
