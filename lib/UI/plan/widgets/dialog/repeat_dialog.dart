import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../../../../business_logic/plan/repeat_dialog_logic.dart'
    as repeat_dialog_logic;
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../widgets/deep_expand_base_dialog.dart';
import '../../utility/repeat_type.dart';
import '../day_selector.dart';
import '../number_repeat_text_field.dart';
import '../repeat_type_menu.dart';

class RepeatDialog extends StatefulWidget {
  final CreatePlanProvider createPlanProvider;

  const RepeatDialog({@required this.createPlanProvider});

  @override
  _RepeatDialogState createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<RepeatDialog> {
  TextEditingController _numberTextField;
  CreatePlanProvider _createPlanProvider;
  RepeatDialogProvider _repeatDialogProvider;

  @override
  void initState() {
    super.initState();
    _createPlanProvider = widget.createPlanProvider;
    _repeatDialogProvider =
        Provider.of<RepeatDialogProvider>(context, listen: false);
    _numberTextField =
        TextEditingController(text: '${_createPlanProvider.getNumberOfRepeat}');

    _repeatDialogProvider.initiateTempWeekDays =
        _createPlanProvider.getWeekDays;
    _repeatDialogProvider.initiateTempRepeat =
        _createPlanProvider.getRepeat ?? RepeatType.Daily;
    _repeatDialogProvider.initiateTempRepeatDialogType =
        _createPlanProvider.getRepeatDialogType;
    _repeatDialogProvider.initiateTempNumberOfRepeat =
        _createPlanProvider.getNumberOfRepeat;
    _repeatDialogProvider.initiateTempSelectedDays =
        _createPlanProvider.getSelectedDays.isEmpty
            ? [1]
            : _createPlanProvider.getSelectedDays;
  }

  @override
  void dispose() {
    _numberTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DeepExpandBaseDialog(
      childrenPadding: const EdgeInsets.only(
          top: 16.0, right: 24.0, left: 24.0, bottom: 32.0),
      title: Text(
        'Repeat every ...',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            color: themeColorOpacity(context: context, opacity: .7),
            fontSize: SizeHelper.getTitle),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              NumberRepeatTextField(controller: _numberTextField),
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
                        repeat_dialog_logic.create(
                            locale: Localizations.localeOf(context),
                            createPlanProvider: _createPlanProvider,
                            repeatDialogProvider: _repeatDialogProvider);

                        Navigator.pop(context);
                      }
                          : null,
                      child: textDone),
              child: Text(
                'Done',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: SizeHelper.getModalButton,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
