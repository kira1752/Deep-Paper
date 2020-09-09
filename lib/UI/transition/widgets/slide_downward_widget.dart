import 'package:flutter/material.dart';

class SlideDownwardWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  SlideDownwardWidget(
      {@required this.child, @required this.duration, this.reverseDuration});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          final Animatable<double> _fastOutSlowInTween =
              CurveTween(curve: Curves.fastOutSlowIn);
          final Animatable<double> _easeInTween =
              CurveTween(curve: Curves.easeIn);
          final _slideTween = Tween<Offset>(
            begin: const Offset(0.0, -0.25),
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
        },
        layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        duration: duration,
        reverseDuration: reverseDuration ?? const Duration(milliseconds: 0),
        child: child,
      ),
    );
  }
}
