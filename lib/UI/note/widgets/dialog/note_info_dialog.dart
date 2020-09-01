import 'package:deep_paper/UI/widgets/deep_base_dialog.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteInfoDialog extends StatelessWidget {
  final String folderName;
  final DateTime modified;
  final DateTime created;

  NoteInfoDialog(
      {@required this.folderName,
      @required this.modified,
      @required this.created});

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 24.0),
      actionsPadding: 24.0,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).accentColor.withOpacity(.20)))),
        child: Text(
          'Note Info',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: SizeHelper.getTitle),
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
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: SizeHelper.getModalButton,
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
                    ':',
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
                  '$folderName',
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
                  'Created',
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
                    ':',
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
                'Modified',
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
                  ':',
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
    );
  }
}
