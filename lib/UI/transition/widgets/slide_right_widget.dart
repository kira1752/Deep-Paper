import 'package:flutter/material.dart';

class SlideRightWidget extends StatelessWidget {
  final Widget child;

  SlideRightWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        final Animatable<double> _fastOutSlowInTween =
            CurveTween(curve: Curves.fastOutSlowIn);
        final Animatable<double> _easeInTween =
            CurveTween(curve: Curves.easeIn);
        final Tween<Offset> _slideTween = Tween<Offset>(
          begin: const Offset(-0.25, 0.0),
          end: Offset.zero,
        );

        final Animation<Offset> _positionAnimation =
            animation.drive(_slideTween.chain(_fastOutSlowInTween));
        final Animation<double> _opacityAnimation =
            animation.drive(_easeInTween);

        return SlideTransition(
          position: _positionAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: child,
          ),
        );
      },
      duration: Duration(milliseconds: 300),
      child: child,
    );
  }
}
