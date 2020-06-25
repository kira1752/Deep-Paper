import 'package:deep_paper/UI/transition/deep_slide.dart';
import 'package:flutter/material.dart';

class DeepRoute extends PageRouteBuilder {
  DeepRoute({@required Widget page, RouteSettings settings})
      : super(
          opaque: false,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 300),
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryRouteAnimation,
            Animation<double> secondaryRouteAnimation,
            Widget child,
          ) =>
              DeepSlide(
                child: child,
                routeAnimation: primaryRouteAnimation,
              ),
        );
}
