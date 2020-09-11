import 'package:flutter/material.dart';

class SlideLeftWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration reverseDuration;

  SlideLeftWidget({@required this.child, this.duration, this.reverseDuration});

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
        },
        layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        duration: duration ?? const Duration(milliseconds: 400),
        reverseDuration: reverseDuration ?? const Duration(),
        child: child,
      ),
    );
  }
}
