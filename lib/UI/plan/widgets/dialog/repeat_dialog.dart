import 'package:deep_paper/UI/plan/utility/repeat_type.dart';
import 'package:deep_paper/UI/plan/widgets/day_selector.dart';
import 'package:deep_paper/UI/plan/widgets/number_repeat_text_field.dart';
import 'package:deep_paper/UI/plan/widgets/repeat_type_menu.dart';
import 'package:deep_paper/UI/widgets/deep_expand_base_dialog.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:deep_paper/business_logic/plan/repeat_dialog_logic.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepeatDialog extends StatefulWidget {
  @override
  _RepeatDialogState createState() => _RepeatDialogState();
}

class _RepeatDialogState extends State<RepeatDialog> {
  TextEditingController _numberTextField;

  @override
  void initState() {
    super.initState();
    final createPlanProvider =
        Provider.of<CreatePlanProvider>(context, listen: false);
    final repeatDialogProvider =
        Provider.of<RepeatDialogProvider>(context, listen: false);
    _numberTextField =
        TextEditingController(text: '${createPlanProvider.getNumberOfRepeat}');

    repeatDialogProvider.initiateTempWeekDays = createPlanProvider.getWeekDays;
    repeatDialogProvider.initiateTempRepeat =
        createPlanProvider.getRepeat ?? RepeatType.Daily;
    repeatDialogProvider.initiateTempRepeatDialogType =
        createPlanProvider.getRepeatDialogType;
    repeatDialogProvider.initiateTempNumberOfRepeat =
        createPlanProvider.getNumberOfRepeat;
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
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: SizeHelper.getTitle),
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
          builder: (context, showWeekDays, child) =>
              showWeekDays ? const DaySelector() : const SizedBox(),
        )
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
            child: Selector<RepeatDialogProvider, bool>(
              selector: (context, provider) =>
                  provider.getTempNumberOfRepeat != 0,
              builder: (context, canTap, child) => FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textColor: Theme.of(context).accentColor.withOpacity(0.87),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12.0))),
                  onPressed: canTap
                      ? () {
                          RepeatDialogLogic.create(context: context);
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: SizeHelper.getModalButton,
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
