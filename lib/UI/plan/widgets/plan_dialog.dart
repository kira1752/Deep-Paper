import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../plan_detail/widgets/dialog/repeat_dialog.dart';

Future<void> openRepeatDialog(
    {@required BuildContext context,
    @required CreatePlanProvider createPlanProvider}) {
  return showDialog(
    context: context,
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: createPlanProvider),
        ChangeNotifierProvider(
          create: (context) => RepeatDialogProvider(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => RepeatDialogProvider(),
        child: const RepeatDialog(),
      ),
    ),
  );
}
