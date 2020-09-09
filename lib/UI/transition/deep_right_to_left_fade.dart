import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeepRightToLeftFade extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve curve,
      Alignment alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final Animatable<double> _fastOutSlowInTween =
        CurveTween(curve: Curves.fastOutSlowIn);
    final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
    final _slideTween = Tween<Offset>(
      begin: const Offset(0.25, 0.0),
      end: Offset.zero,
    );

    final _positionAnimation =
        animation.drive(_slideTween.chain(_fastOutSlowInTween));
    final _opacityAnimation = animation.drive(_easeInTween);

    return SlideTransition(
      position: _positionAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: child,
      ),
    );
  }
}
