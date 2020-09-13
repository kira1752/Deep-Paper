import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../widgets/create_plan_page.dart';

class CreatePlan {
  static Future<void> show() {
    return Get.bottomSheet(
      ChangeNotifierProvider(
        create: (context) => CreatePlanProvider(),
        child: const CreatePlanPage(),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }
}
