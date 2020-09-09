import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:flutter/widgets.dart';

class DaySelectorLogic {
  DaySelectorLogic._();

  static void onChanged(
      {@required RepeatDialogProvider repeatDialogProvider,
      @required int day,
      @required List<bool> weekDays}) {
    if (weekDays.where((day) => day == true).length == 1) {
      if (weekDays[day % 7] != true) {
        repeatDialogProvider.setTempWeekDays = day;
        repeatDialogProvider.addSelectedDay = day;
      }
    } else {
      repeatDialogProvider.setTempWeekDays = day;
      if (repeatDialogProvider.getTempWeekDays[day % 7] == true) {
        repeatDialogProvider.addSelectedDay = day;
      } else {
        repeatDialogProvider.removeSelectedDay = day;
      }
    }
  }
}
