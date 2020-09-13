import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../business_logic/note/trash_management.dart';
import '../../../../data/deep.dart';
import '../../../../utility/size_helper.dart';
import '../../../widgets/deep_base_dialog.dart';
import '../../../widgets/deep_toast.dart';

class RestoreDialog extends StatelessWidget {
  final Note data;

  const RestoreDialog({@required this.data});

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
          'Restore note',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: SizeHelper.getTitle),
        ),
      ),
      children: [
        Text(
          'Restore this note to access all of its content.',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: SizeHelper.getModalDescription,
              color: Colors.white.withOpacity(0.87)),
        ),
      ],
      actions: [
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: Colors.white.withOpacity(0.87),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12.0))),
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
            child: FlatButton(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textColor: Theme.of(context).accentColor.withOpacity(0.87),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(12.0))),
                onPressed: () {
                  TrashManagement.restore(data: data);

                  DeepToast.showToast(
                      description: 'Note restored successfully');

                  Get.back();
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
