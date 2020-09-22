import 'package:flutter/material.dart';

class DeepRoute<T> extends MaterialPageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  DeepRoute({
    @required this.builder,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  final WidgetBuilder builder;

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 400);
}
