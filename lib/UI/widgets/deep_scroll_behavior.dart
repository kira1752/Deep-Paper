import 'package:flutter/widgets.dart';

class DeepScrollBehavior extends ScrollBehavior {
  const DeepScrollBehavior();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
