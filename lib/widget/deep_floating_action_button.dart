import 'dart:math';

import 'package:deep_paper/widget/deep_fab_controller.dart';
import 'package:flutter/material.dart';

class DeepFloatingActionButton extends StatelessWidget {

  DeepFloatingActionButton({
    @required this.actions,
    this.onAction,
    @required this.icon,
    this.animationDuration = 250,
    this.controller,
  });

  final List<DeepAction> actions;
  final ValueChanged<int> onAction;
  final Widget icon;
  final int animationDuration;
  final DeepController controller;

  @override
  Widget build(BuildContext context) {
    return Deep(
      controller: controller,
      actions: actions,
      onAction: onAction,
      icon: icon,
      animationDuration: animationDuration,
    );
  }
}

class DeepAction{
  DeepAction({this.icon, this.tooltip});
  final Widget icon;
  final String tooltip;
}

class Deep extends StatefulWidget {
  Deep({
    @required this.actions,
    this.onAction,
    @required this.icon,
    this.animationDuration,
    this.controller,
  });

  final DeepController controller;
  final List<DeepAction> actions;
  final ValueChanged<int> onAction;
  final Widget icon;
  final int animationDuration;

  @override
  State createState() => _DeepState();
}

class _DeepState extends State<Deep> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );

    widget.controller ?? DeepController()
      ..setAnimator(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildActions();
  }

  Widget _buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.actions.length, (int index) {
        return _buildChild(index);
      })
        ..add(
          _buildFab(),
        ),
    );
  }

  Widget _buildChild(int index) {
    Color backgroundColor = Color(0xff1C2A41);
    return Container(
      height: 70.0,
      width: 56.0,
      alignment: FractionalOffset.topCenter,
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, (index + 1) / widget.actions.length,
              curve: Curves.linear),
        ),
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: backgroundColor,
          mini: true,
          tooltip: widget.actions[index].tooltip,
          child: widget.actions[index].icon,
          onPressed: () => _onAction(index),
        ),
      ),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xff1C2A41),
      onPressed: toggle,
      child: AnimatedBuilder(
          animation: _controller,
          child: widget.icon,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * pi / 4,
              child: child,
            );
          }),
      elevation: 2.0,
    );
  }

  void toggle() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onAction(int index) {
    _controller.reverse();
    widget.onAction(index);
  }
}
