import 'package:deep_paper/UI/plan/widgets/dialog/repeat_dialog.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanDialog {
  PlanDialog._();

  static Future<void> openRepeatDialog(
      {@required BuildContext context,
      @required CreatePlanProvider createPlanProvider}) {
    return showDialog(
        context: context,
        builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) => RepeatDialogProvider()),
                ChangeNotifierProvider.value(value: createPlanProvider),
              ],
              child: RepeatDialog(),
            ));
  }
}
