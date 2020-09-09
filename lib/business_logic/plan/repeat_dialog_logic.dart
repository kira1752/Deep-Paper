import 'package:deep_paper/UI/plan/utility/repeat_type.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

class RepeatDialogLogic {
  RepeatDialogLogic._();

  static void create(
      {@required CreatePlanProvider createPlanProvider,
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

    final _locale = Localizations.localeOf(Get.context);
    final DateSymbols _dateSymbols = dateTimeSymbolMap()['$_locale'];

    final selectedDays =
        List.generate(createPlanProvider.getSelectedDays.length, (index) {
      final selectedDay = createPlanProvider.getSelectedDays[index];
      return _dateSymbols.STANDALONEWEEKDAYS[selectedDay % 7];
    });

    if (createPlanProvider.getNumberOfRepeat == 1) {
      switch (createPlanProvider.getRepeat) {
        case RepeatType.Daily:
          createPlanProvider.setRepeatTitle = 'Daily';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Weekly:
          createPlanProvider.setRepeatTitle = 'Weekly';
          createPlanProvider.setSelectedDaysTitle = selectedDays.join(', ');
          break;
        case RepeatType.Monthly:
          createPlanProvider.setRepeatTitle = 'Monthly';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Yearly:
          createPlanProvider.setRepeatTitle = 'Yearly';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
      }
    } else {
      switch (createPlanProvider.getRepeat) {
        case RepeatType.Daily:
          createPlanProvider.setRepeatTitle =
              'Every ${createPlanProvider.getNumberOfRepeat} days';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Weekly:
          createPlanProvider.setRepeatTitle =
              'Every ${createPlanProvider.getNumberOfRepeat} weeks';
          createPlanProvider.setSelectedDaysTitle = selectedDays.join(', ');
          break;
        case RepeatType.Monthly:
          createPlanProvider.setRepeatTitle =
              'Every ${createPlanProvider.getNumberOfRepeat} months';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
        case RepeatType.Yearly:
          createPlanProvider.setRepeatTitle =
              'Every ${createPlanProvider.getNumberOfRepeat} years';
          createPlanProvider.setSelectedDaysTitle = '';
          break;
      }
    }
  }
}
