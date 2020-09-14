import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../widgets/create_plan_page.dart';

Future<void> show(
    {@required BuildContext context, @required BuildContext mainContext}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => CreatePlanProvider(),
      child: CreatePlanPage(
        mainContext: mainContext,
      ),
    ),
  );
}
