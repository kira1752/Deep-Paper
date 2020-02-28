import 'package:flutter/animation.dart';

class DeepController {
  DeepController();

  AnimationController _animationController;

  setAnimator(AnimationController controller) {
    _animationController = controller;
  }

  unfold() {
    if (_animationController.isDismissed == false) {
      _animationController.reverse();
    }
  }
}
