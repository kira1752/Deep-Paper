import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../../../widgets/deep_dialog_route.dart';
import 'repeat_dialog.dart';

// PlanDialog Utility class
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
