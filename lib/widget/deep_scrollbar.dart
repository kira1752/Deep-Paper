// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kDeepScrollbarThickness = 3.0;
const Duration _kDeepScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kDeepScrollbarTimeToFade = Duration(milliseconds: 600);

/// A material design Deepscrollbar.
///
/// A Deepscrollbar indicates which portion of a [Scrollable] widget is actually
/// visible.
///
/// Dynamically changes to an iOS style Deepscrollbar that looks like
/// [CupertinoDeepScrollbar] on the iOS platform.
///
/// To add a Deepscrollbar to a [ScrollView], simply wrap the scroll view widget in
/// a [DeepScrollbar] widget.
///
/// See also:
///
///  * [ListView], which display a linear, scrollable list of children.
///  * [GridView], which display a 2 dimensional, scrollable array of children.
class DeepScrollbar extends StatefulWidget {
  /// Creates a material design Deepscrollbar that wraps the given [child].
  ///
  /// The [child] should be a source of [ScrollNotification] notifications,
  /// typically a [Scrollable] widget.
  const DeepScrollbar({
    Key key,
    @required this.child,
    this.controller,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// The Deepscrollbar will be stacked on top of this child. This child (and its
  /// subtree) should include a source of [ScrollNotification] notifications.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  /// {@macro flutter.cupertino.cupertinoDeepScrollbar.controller}
  final ScrollController controller;

  @override
  _DeepScrollbarState createState() => _DeepScrollbarState();
}

class _DeepScrollbarState extends State<DeepScrollbar> with TickerProviderStateMixin {
  ScrollbarPainter _materialPainter;
  TextDirection _textDirection;
  Color _themeColor;
  bool _useCupertinoDeepScrollbar;
  AnimationController _fadeoutAnimationController;
  Animation<double> _fadeoutOpacityAnimation;
  Timer _fadeoutTimer;

  @override
  void initState() {
    super.initState();
    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kDeepScrollbarFadeDuration,
    );
    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert((() {
      _useCupertinoDeepScrollbar = null;
      return true;
    })());
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // On iOS, stop all local animations. CupertinoDeepScrollbar has its own
        // animations.
        _fadeoutTimer?.cancel();
        _fadeoutTimer = null;
        _fadeoutAnimationController.reset();
        _useCupertinoDeepScrollbar = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        _themeColor = theme.highlightColor.withOpacity(1.0);
        _textDirection = Directionality.of(context);
        _materialPainter = _buildMaterialDeepScrollbarPainter();
        _useCupertinoDeepScrollbar = false;
        break;
    }
    assert(_useCupertinoDeepScrollbar != null);
  }

  ScrollbarPainter _buildMaterialDeepScrollbarPainter() {
    return ScrollbarPainter(
      color: _themeColor,
      textDirection: _textDirection,
      thickness: _kDeepScrollbarThickness,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
      padding: MediaQuery.of(context).padding,
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      return false;
    }

    // iOS sub-delegates to the CupertinoDeepScrollbar instead and doesn't handle
    // scroll notifications here.
    if (!_useCupertinoDeepScrollbar &&
        (notification is ScrollUpdateNotification || notification is OverscrollNotification)) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _materialPainter.update(notification.metrics, notification.metrics.axisDirection);
      _fadeoutTimer?.cancel();
      _fadeoutTimer = Timer(_kDeepScrollbarTimeToFade, () {
        _fadeoutAnimationController.reverse();
        _fadeoutTimer = null;
      });
    }
    return false;
  }

  @override
  void dispose() {
    _fadeoutAnimationController.dispose();
    _fadeoutTimer?.cancel();
    _materialPainter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useCupertinoDeepScrollbar) {
      return CupertinoScrollbar(
        child: widget.child,
        controller: widget.controller,
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RepaintBoundary(
        child: CustomPaint(
          foregroundPainter: _materialPainter,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
