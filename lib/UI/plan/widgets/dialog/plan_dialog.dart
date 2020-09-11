import 'package:deep_paper/UI/plan/widgets/dialog/repeat_dialog.dart';
import 'package:deep_paper/UI/widgets/deep_dialog_route.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/repeat_dialog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanDialog {
  PlanDialog._();

  static Future<void> openRepeatDialog(
      {@required CreatePlanProvider createPlanProvider}) {
    return DeepDialogRoute.dialog(
      ChangeNotifierProvider(
        create: (context) => RepeatDialogProvider(),
        child: RepeatDialog(
          createPlanProvider: createPlanProvider,
        ),
      ),
    );
  }
}
