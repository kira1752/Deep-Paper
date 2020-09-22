import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../utility/repeat_type.dart';

class RepeatTypeMenu extends StatelessWidget {
  const RepeatTypeMenu();

  @override
  Widget build(BuildContext context) {
    final _repeatDialogProvider =
        Provider.of<RepeatDialogProvider>(context, listen: false);

    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            value: RepeatType.Daily,
            child: Text(
              'days',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: themeColorOpacity(context: context, opacity: .8),
                  fontSize: SizeHelper.getModalTextField),
            )),
        PopupMenuItem(
            value: RepeatType.Weekly,
            child: Text(
              'weeks',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: themeColorOpacity(context: context, opacity: .8),
                  fontSize: SizeHelper.getModalTextField),
            )),
        PopupMenuItem(
            value: RepeatType.Monthly,
            child: Text(
              'months',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: themeColorOpacity(context: context, opacity: .8),
                  fontSize: SizeHelper.getModalTextField),
            )),
        PopupMenuItem(
            value: RepeatType.Yearly,
            child: Text(
              'years',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: themeColorOpacity(context: context, opacity: .8),
                  fontSize: SizeHelper.getModalTextField),
            )),
      ],
      onSelected: (value) {
        _repeatDialogProvider.setTempRepeat = value;
        switch (value) {
          case RepeatType.Daily:
            _repeatDialogProvider.setTempRepeatDialogType = 'days';
            break;
          case RepeatType.Weekly:
            _repeatDialogProvider.setTempRepeatDialogType = 'weeks';
            break;
          case RepeatType.Monthly:
            _repeatDialogProvider.setTempRepeatDialogType = 'months';
            break;
          case RepeatType.Yearly:
            _repeatDialogProvider.setTempRepeatDialogType = 'years';
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Selector<RepeatDialogProvider, String>(
                selector: (context, provider) =>
                    provider.getTempRepeatDialogType,
                builder: (context, repeatTypeTitle, _) => Text(
                  '$repeatTypeTitle',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: themeColorOpacity(context: context, opacity: .8),
                      fontSize: SizeHelper.getModalTextField),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: themeColorOpacity(context: context, opacity: .8),
            )
          ],
        ),
      ),
    );
  }
}
