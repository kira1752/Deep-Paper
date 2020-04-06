import 'package:flutter/material.dart';

class Slide extends PageRouteBuilder {
  Slide({Widget page, RouteSettings settings})
      : super(
          opaque: false,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 600),
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
              SlideTransition(
            position: CurvedAnimation(
              parent: secondaryRouteAnimation,
              curve: Curves.linearToEaseOut,
              reverseCurve: Curves.easeInToLinear,
            ).drive(Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0 / 3.0, 0.0),
            )),
            transformHitTests: false,
            child: SlideTransition(
              position: CurvedAnimation(
                // The curves below have been rigorously derived from plots of native
                // iOS animation frames. Specifically, a video was taken of a page
                // transition animation and the distance in each frame that the page
                // moved was measured. A best fit bezier curve was the fitted to the
                // point set, which is linearToEaseIn. Conversely, easeInToLinear is the
                // reflection over the origin of linearToEaseIn.
                parent: primaryRouteAnimation,
                curve: Curves.linearToEaseOut,
                reverseCurve: Curves.easeInToLinear,
              ).drive(Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              )),
              child: child,
            ),
          ),
        );
}
