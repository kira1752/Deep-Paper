import 'package:flutter/material.dart';

import '../../utility/extension.dart';
import 'deep_scroll_behavior.dart';

class DeepBaseDialog extends StatelessWidget {
  final Widget title;
  final EdgeInsets titlePadding;
  final List<Widget> children;
  final EdgeInsets childrenPadding;
  final Widget optionalScrollable;
  final List<Widget> actions;
  final double actionsPadding;
  final EdgeInsets insetPadding;

  const DeepBaseDialog(
      {this.title,
      this.titlePadding,
      this.children,
      this.childrenPadding,
      this.actions,
      this.actionsPadding,
      this.optionalScrollable,
      this.insetPadding});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetAnimationCurve: Curves.easeOutQuad,
        insetPadding: insetPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 0.0,
            ),
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
                                ? (actionsPadding ?? 32.0)
                                : 0.0),
                    child: title,
                  ),
                if (children.isNotNull)
                  Flexible(
                    child: ScrollConfiguration(
                      behavior: const DeepScrollBehavior(),
                      child: SingleChildScrollView(
                        padding: childrenPadding ??
                            EdgeInsets.fromLTRB(
                                24.0,
                                24.0,
                                24.0,
                                actions.isNotNull
                                    ? (actionsPadding ?? 32.0)
                                    : 0.0),
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
                          border: Border(
                              top: Divider.createBorderSide(context,
                                  width: 1.0))),
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
