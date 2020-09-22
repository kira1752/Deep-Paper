import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/trash_management.dart'
    as trash_management;
import '../../../../data/deep.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_base_dialog.dart';
import '../../../widgets/deep_snack_bar.dart';

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
          style: TextStyle(
            fontSize: SizeHelper.getHeadline6,
            fontWeight: FontWeight.w600,
            color: themeColorOpacity(context: context, opacity: .87),
          ),
        ),
      ),
      children: [
        Text(
          StringResource.restoreNoteDescription,
          strutStyle: const StrutStyle(leading: 0.5),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: themeColorOpacity(context: context, opacity: .7),
              fontSize: SizeHelper.getModalDescription),
        ),
      ],
      actions: [
        Expanded(
          child: FlatButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              textColor: themeColorOpacity(context: context, opacity: .87),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(12.0))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
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
                  final database =
                  Provider.of<DeepPaperDatabase>(context, listen: false);

                  trash_management.restore(data: data, database: database);

                  Navigator.pop(context);

                  showSnack(
                      context: context,
                      icon: successful(context: context),
                      description: 'Note restored successfully');
                },
                child: Text(
                  'Restore',
                  style: TextStyle(
                    fontSize: SizeHelper.getModalButton,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
