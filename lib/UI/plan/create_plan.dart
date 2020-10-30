import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/plan/provider/create_plan_provider.dart';
import 'plan_detail/create_plan_page.dart';

Future<void> show({@required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ChangeNotifierProvider(
      create: (context) => CreatePlanProvider(),
      child: const CreatePlanPage(),
    ),
  );
}
