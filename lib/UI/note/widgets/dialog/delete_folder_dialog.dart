import 'package:deep_paper/UI/widgets/deep_base_dialog.dart';
import 'package:deep_paper/UI/widgets/deep_toast.dart';
import 'package:deep_paper/business_logic/note/folder_creation.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class DeleteFolderDialog extends StatefulWidget {
  final NoteDrawerProvider drawerProvider;

  DeleteFolderDialog({@required this.drawerProvider});

  @override
  _DeleteFolderDialogState createState() => _DeleteFolderDialogState();
}

class _DeleteFolderDialogState extends State<DeleteFolderDialog> {
  NoteDrawerProvider drawerProvider;

  @override
  void initState() {
    super.initState();

    drawerProvider = widget.drawerProvider;
  }

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 24.0),
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).accentColor.withOpacity(.20)))),
        child: Text(
          'Delete folder',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: SizeHelper.getTitle),
        ),
      ),
      children: [
        Text(
          'All notes inside this folder will be deleted.',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeHelper.getModalDescription,
              color: Colors.white.withOpacity(0.87)),
        ),
      ],
      actions: <Widget>[
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: Colors.white.withOpacity(0.87),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12.0))),
              onPressed: () {
                Navigator.of(context).pop();
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
            child: FlatButton(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textColor: Theme.of(context).accentColor.withOpacity(0.87),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(12.0))),
                onPressed: () {
                  FolderCreation.delete(
                      context: context, drawerProvider: drawerProvider);

                  DeepToast.showToast(
                      description: 'Folder deleted successfully');

                  Navigator.of(context).pop();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: SizeHelper.getModalButton,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
