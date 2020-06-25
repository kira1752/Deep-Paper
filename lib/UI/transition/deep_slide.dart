import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeepSlide extends StatelessWidget {
  static final Animatable<double> _fastOutSlowInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final Animation<Offset> _positionAnimation;
  final Animation<double> _opacityAnimation;
  final Widget child;

  DeepSlide({
    Key key,
    @required
        Animation<double>
            routeAnimation, // The route's linear 0.0 - 1.0 animation.
    @required this.child,
  })  : _positionAnimation =
            routeAnimation.drive(_slideTween.chain(_fastOutSlowInTween)),
        _opacityAnimation = routeAnimation.drive(_easeInTween),
        super(key: key);

  // Fractional offset from 1/4 screen from right to fully on screen.
  static final Tween<Offset> _slideTween = Tween<Offset>(
    begin: const Offset(0.25, 0.0),
    end: Offset.zero,
  );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: child,
      ),
    );
  }
}
