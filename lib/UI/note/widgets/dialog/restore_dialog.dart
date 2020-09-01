import 'package:deep_paper/UI/widgets/deep_base_dialog.dart';
import 'package:deep_paper/UI/widgets/deep_toast.dart';
import 'package:deep_paper/business_logic/note/trash_management.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class RestoreDialog extends StatelessWidget {
  final Note data;

  RestoreDialog({@required this.data});

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      title: Text(
        'Restore this note',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: SizeHelper.getTitle),
      ),
      actions: [
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
                  TrashManagement.restore(context: context, data: data);

                  DeepToast.showToast(
                      description: 'Note restored successfully');

                  Navigator.of(context).pop();
                },
                child: Text(
                  'Restore',
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
