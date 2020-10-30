import 'package:flutter/material.dart';

import '../../utility/extension.dart';
import 'deep_scroll_behavior.dart';

class DeepBaseDialog extends StatelessWidget {
  final Widget title;
  final Widget optionalScrollable;
  final List<Widget> children;
  final List<Widget> actions;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry childrenPadding;
  final EdgeInsetsGeometry insetPadding;
  final double actionsPadding;

  const DeepBaseDialog(
      {this.title,
      this.titlePadding,
      this.children,
      this.childrenPadding,
      this.actions,
      this.actionsPadding = 32.0,
      this.optionalScrollable,
      this.insetPadding = const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 0.0,
      )});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetAnimationCurve: Curves.easeOutQuad,
        insetPadding: insetPadding,
        child: IntrinsicWidth(
          stepWidth: 56,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title.isNotNull)
                  Padding(
                    padding: titlePadding ??
                        EdgeInsets.fromLTRB(
                            24.0,
                            24.0,
                            24.0,
                            actions.isNotNull && children.isNull
                                ? actionsPadding
                                : 0.0),
                    child: title,
                  ),
                if (children.isNotNull)
                  Flexible(
                    child: ScrollConfiguration(
                      behavior: const DeepScrollBehavior(),
                      child: SingleChildScrollView(
                        padding: childrenPadding ??
                            EdgeInsets.fromLTRB(24.0, 24.0, 24.0,
                                actions.isNotNull ? (actionsPadding) : 0.0),
                        child: ListBody(
                          children: children,
                        ),
                      ),
                    ),
                  ),
                if (optionalScrollable.isNotNull)
                  Flexible(child: optionalScrollable),
                if (actions.isNotNull)
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(top: Divider.createBorderSide(context))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
