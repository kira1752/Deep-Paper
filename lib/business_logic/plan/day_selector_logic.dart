import 'package:flutter/foundation.dart';

import '../provider/plan/repeat_dialog_provider.dart';

void onChanged(
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
