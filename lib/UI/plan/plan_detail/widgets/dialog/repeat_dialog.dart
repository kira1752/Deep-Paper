import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../../../../../business_logic/plan/repeat_dialog_logic.dart';
import '../../../../../utility/size_helper.dart';
import '../../../../app_theme.dart';
import '../../../../widgets/deep_expand_base_dialog.dart';
import '../../../utility/repeat_type.dart';
import '../day_selector.dart';
import '../number_repeat_text_field.dart';
import '../repeat_type_menu.dart';

class RepeatDialog extends StatefulWidget {
  const RepeatDialog();

  @override
  _RepeatDialogState createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<RepeatDialog> with RepeatDialogLogic {
  @override
  Widget build(BuildContext context) {
    return DeepExpandBaseDialog(
      childrenPadding: const EdgeInsets.only(
          top: 16.0, right: 24.0, left: 24.0, bottom: 32.0),
      title: Text(
        'Repeat every ...',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: themeColorOpacity(context: context, opacity: .7),
            fontSize: SizeHelper.title),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              NumberRepeatTextField(controller: numberTextField),
              const RepeatTypeMenu()
            ],
          ),
        ),
        Selector<RepeatDialogProvider, bool>(
          selector: (context, provider) =>
              provider.getTempRepeat == RepeatType.Weekly,
          child: const DaySelector(),
          builder: (context, showWeekDays, daySelector) =>
              showWeekDays ? daySelector : const SizedBox(),
        )
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
            child: Selector<RepeatDialogProvider, bool>(
              selector: (context, provider) =>
              provider.getTempNumberOfRepeat != 0,
              builder: (context, canTap, textDone) =>
                  FlatButton(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textColor: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.87),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0))),
                      onPressed: canTap
                          ? () {
                        create(
                            locale: Localizations.localeOf(context),
                            createPlanProvider: createPlanProvider,
                            repeatDialogProvider: repeatDialogProvider);

                        Navigator.pop(context);
                      }
                          : null,
                      child: textDone),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: SizeHelper.modalButton,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
