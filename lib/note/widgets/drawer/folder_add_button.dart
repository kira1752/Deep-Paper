import 'package:deep_paper/note/widgets/bottom_modal.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class FolderAddButton extends StatelessWidget {
  FolderAddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          "FOLDERS",
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white.withOpacity(0.70),
              fontSize: SizeHelper.getBodyText1),
        ),
        trailing: FlatButton(
            shape: StadiumBorder(
                side: BorderSide(
                    color: Theme.of(context).accentColor, width: 2.0)),
            onPressed: () {
              BottomModal.openCreateFolderDialog(context: context);
            },
            child: Text(
              "ADD",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontSize: SizeHelper.getButton),
            )));
  }
}
