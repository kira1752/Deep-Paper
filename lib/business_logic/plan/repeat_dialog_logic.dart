import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';

import '../../UI/plan/utility/repeat_type.dart';
import '../../resource/string_resource.dart';
import '../provider/plan/create_plan_provider.dart';
import '../provider/plan/repeat_dialog_provider.dart';

mixin RepeatDialogLogic<T extends StatefulWidget> on State<T> {
  TextEditingController numberTextField;
  CreatePlanProvider createPlanProvider;
  RepeatDialogProvider repeatDialogProvider;

  @override
  void initState() {
    super.initState();
    createPlanProvider = context.read<CreatePlanProvider>();
    repeatDialogProvider = context.read<RepeatDialogProvider>();
    numberTextField =
        TextEditingController(text: '${createPlanProvider.getNumberOfRepeat}');

    repeatDialogProvider.initiateTempWeekDays = createPlanProvider.getWeekDays;
    repeatDialogProvider.initiateTempRepeat =
        createPlanProvider.getRepeat ?? RepeatType.Daily;
    repeatDialogProvider.initiateTempRepeatDialogType =
        createPlanProvider.getRepeatDialogType;
    repeatDialogProvider.initiateTempNumberOfRepeat =
        createPlanProvider.getNumberOfRepeat;
    repeatDialogProvider.initiateTempSelectedDays =
        createPlanProvider.getSelectedDays.isEmpty
            ? [1]
            : createPlanProvider.getSelectedDays;
  }

  @override
  void dispose() {
    numberTextField.dispose();
    super.dispose();
  }

  void create(
      {@required Locale locale,
      @required CreatePlanProvider createPlanProvider,
      @required RepeatDialogProvider repeatDialogProvider}) {
    repeatDialogProvider.getTempSelectedDays
        .sort((dayA, dayB) => dayA.compareTo(dayB));

    createPlanProvider.setNumberOfRepeat =
        repeatDialogProvider.getTempNumberOfRepeat;
    createPlanProvider.setRepeatDialogType =
        repeatDialogProvider.getTempRepeatDialogType;
    createPlanProvider.setRepeat = repeatDialogProvider.getTempRepeat;
    createPlanProvider.setWeekDays = repeatDialogProvider.getTempWeekDays;
    createPlanProvider.setSelectedDays =
        repeatDialogProvider.getTempSelectedDays;

    final DateSymbols _dateSymbols = dateTimeSymbolMap()['$locale'];

    final selectedDays =
        List.generate(createPlanProvider.getSelectedDays.length, (index) {
      var selectedDay = createPlanProvider.getSelectedDays[index];
      return _dateSymbols.STANDALONEWEEKDAYS[selectedDay % 7];
    });

    if (createPlanProvider.getNumberOfRepeat == 1) {
      switch (createPlanProvider.getRepeat) {
        case RepeatType.Daily:
          createPlanProvider.setRepeatTitle = StringResource.daily;
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Weekly:
          createPlanProvider.setRepeatTitle = StringResource.weekly;
          createPlanProvider.setSelectedDaysTitle = selectedDays.join(', ');
          break;
        case RepeatType.Monthly:
          createPlanProvider.setRepeatTitle = StringResource.monthly;
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Yearly:
          createPlanProvider.setRepeatTitle = StringResource.yearly;
          createPlanProvider.setSelectedDaysTitle = '';
          break;
      }
    } else {
      switch (createPlanProvider.getRepeat) {
        case RepeatType.Daily:
          createPlanProvider.setRepeatTitle =
              StringResource.everyNDays(createPlanProvider.getNumberOfRepeat);
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Weekly:
          createPlanProvider.setRepeatTitle =
              StringResource.everyNWeeks(createPlanProvider.getNumberOfRepeat);
          createPlanProvider.setSelectedDaysTitle = selectedDays.join(', ');
          break;
        case RepeatType.Monthly:
          createPlanProvider.setRepeatTitle =
              StringResource.everyNMonths(createPlanProvider.getNumberOfRepeat);
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Yearly:
          createPlanProvider.setRepeatTitle =
              StringResource.everyNYears(createPlanProvider.getNumberOfRepeat);
          createPlanProvider.setSelectedDaysTitle = '';
          break;
      }
    }
  }
}
