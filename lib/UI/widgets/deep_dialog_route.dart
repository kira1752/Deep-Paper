import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class DeepDialogRoute {
  static Future<void> dialog(Widget widget) {
    return Get.dialog(widget,
        transitionDuration: const Duration(milliseconds: 250));
  }
}
