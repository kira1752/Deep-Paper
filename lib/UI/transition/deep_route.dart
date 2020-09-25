import 'package:flutter/material.dart';

class DeepRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  DeepRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  bool get opaque => false;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 400);
}
