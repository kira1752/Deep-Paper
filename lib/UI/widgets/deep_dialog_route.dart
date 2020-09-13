import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

// DeepDialogRoute Utility class
class DeepDialogRoute {
  DeepDialogRoute._();

  static Future<void> dialog(Widget widget) {
    return Get.dialog(widget,
        transitionDuration: const Duration(milliseconds: 200));
  }
}
