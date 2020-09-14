import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import 'repeat_dialog.dart';

Future<void> openRepeatDialog(
    {@required BuildContext context,
    @required CreatePlanProvider createPlanProvider}) {
  return showDialog(
    context: context,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => RepeatDialogProvider(),
      child: RepeatDialog(
        createPlanProvider: createPlanProvider,
      ),
    ),
  );
}
