import 'package:flutter/material.dart';

class Fade extends PageRouteBuilder {
  final Widget page;
  RouteSettings settings;
  Fade({this.page, this.settings})
      : super(
          opaque: false,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 500),
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
