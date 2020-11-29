import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/note/trash_management.dart'
    as trash_management;
import '../../../../data/deep.dart';
import '../../../../resource/icon_resource.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';
import '../../../widgets/deep_base_dialog.dart';
import '../../../widgets/deep_snack_bar.dart';

class RestoreDialog extends StatelessWidget {
  final Note data;

  const RestoreDialog({@required this.data});

  @override
  Widget build(BuildContext context) {
    return DeepBaseDialog(
      titlePadding: const EdgeInsets.all(0.0),
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
            border: Border(bottom: Divider.createBorderSide(context))),
        child: Text(
          'Restore note',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeHelper.headline6,
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
              fontSize: SizeHelper.modalDescription),
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
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: SizeHelper.modalButton,
                ),
              )),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border(left: Divider.createBorderSide(context))),
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
                child: const Text(
                  'Restore',
                  style: TextStyle(
                    fontSize: SizeHelper.modalButton,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
