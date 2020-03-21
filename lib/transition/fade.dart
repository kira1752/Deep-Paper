import 'package:flutter/material.dart';

class Fade extends PageRouteBuilder {
  Fade({Widget page, RouteSettings settings})
      : super(
          opaque: false,
          maintainState: true,
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
