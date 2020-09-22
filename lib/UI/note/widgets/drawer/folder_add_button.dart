import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../dialog/note_dialog.dart' as note_dialog;

class FolderAddButton extends StatelessWidget {
  const FolderAddButton();

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          'FOLDERS',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: themeColorOpacity(context: context, opacity: .7),
              fontSize: SizeHelper.getBodyText1),
        ),
        trailing: RepaintBoundary(
          child: FlatButton(
              splashColor: Theme.of(context).accentColor.withOpacity(0.16),
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Theme.of(context).accentColor, width: 2.0)),
              onPressed: () {
                note_dialog.openCreateFolderDialog(context: context);
              },
              child: Text(
                'ADD',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: themeColorOpacity(context: context, opacity: .87),
                    fontSize: SizeHelper.getAddButton),
              )),
        ));
  }
}
