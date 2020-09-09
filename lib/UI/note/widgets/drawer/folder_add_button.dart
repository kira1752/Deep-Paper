import 'package:deep_paper/UI/note/widgets/dialog/note_dialog.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderAddButton extends StatelessWidget {
  FolderAddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          'FOLDERS',
          style: Get.textTheme.bodyText1
              .copyWith(fontSize: SizeHelper.getBodyText1),
        ),
        trailing: RepaintBoundary(
          child: FlatButton(
              splashColor: Get.theme.accentColor.withOpacity(0.16),
              shape: StadiumBorder(
                  side: BorderSide(color: Get.theme.accentColor, width: 2.0)),
              onPressed: () {
                DeepDialog.openCreateFolderDialog();
              },
              child: Text(
                'ADD',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.87),
                    fontSize: SizeHelper.getAddButton),
              )),
        ));
  }
}
