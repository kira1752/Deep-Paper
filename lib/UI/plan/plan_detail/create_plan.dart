import 'package:deep_paper/UI/plan/widgets/create_plan_page.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlan {
  static Future<void> show(
      {@required BuildContext context, @required BuildContext mainContext}) {
    final _mainContext = mainContext;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => CreatePlanProvider(),
            child: CreatePlanPage(
              mainContext: _mainContext,
            ),
          );
        });
  }
}
