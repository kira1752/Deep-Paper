import 'package:deep_paper/business_logic/plan/day_selector_logic.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class DaySelector extends StatefulWidget {
  final CreatePlanProvider createPlanProvider;

  DaySelector({@required this.createPlanProvider});

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  RepeatDialogProvider _repeatDialogProvider;
  CreatePlanProvider _createPlanProvider;

  @override
  void initState() {
    super.initState();
    _repeatDialogProvider =
        Provider.of<RepeatDialogProvider>(context, listen: false);
    _createPlanProvider = widget.createPlanProvider;

    _repeatDialogProvider.initiateTempSelectedDays =
        _createPlanProvider.getSelectedDays.isEmpty
            ? [1]
            : _createPlanProvider.getSelectedDays;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final dateSymbols = dateTimeSymbolMap()['$locale'];

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Selector<RepeatDialogProvider, List<bool>>(
          selector: (context, provider) => provider.getTempWeekDays,
          builder: (context, weekDays, child) {
            return WeekdaySelector(
                firstDayOfWeek: dateSymbols.FIRSTDAYOFWEEK + 1,
                shortWeekdays: dateSymbols.STANDALONESHORTWEEKDAYS,
                weekdays: dateSymbols.STANDALONEWEEKDAYS,
                selectedFillColor:
                Theme.of(context).accentColor.withOpacity(0.70),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2.0, color: Theme.of(context).canvasColor)),
                selectedShape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2.0, color: Theme.of(context).canvasColor)),
                onChanged: (day) {
                  DaySelectorLogic.onChanged(
                      repeatDialogProvider: _repeatDialogProvider,
                      day: day,
                      weekDays: weekDays);
                },
                values: weekDays);
          }),
    );
  }
}
