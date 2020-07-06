import 'package:flutter/material.dart';

class DeepRoute extends PageRouteBuilder {
  DeepRoute({@required WidgetBuilder page, RouteSettings settings})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
    opaque: false,
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            final widget = page(context);
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> primaryRouteAnimation,
            Animation<double> secondaryRouteAnimation,
            Widget child,
          ) {
            final Animatable<double> _fastOutSlowInTween =
                CurveTween(curve: Curves.fastOutSlowIn);
            final Animatable<double> _easeInTween =
                CurveTween(curve: Curves.easeIn);
            final Tween<Offset> _slideTween = Tween<Offset>(
              begin: const Offset(0.25, 0.0),
              end: Offset.zero,
            );

            final Animation<Offset> _positionAnimation = primaryRouteAnimation
                .drive(_slideTween.chain(_fastOutSlowInTween));
            final Animation<double> _opacityAnimation =
                primaryRouteAnimation.drive(_easeInTween);

            return SlideTransition(
              position: _positionAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: child,
              ),
            );
          },
        );
}
