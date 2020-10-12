import 'package:flutter/material.dart';

import '../../utility/extension.dart';
import 'deep_scroll_behavior.dart';

class DeepExpandBaseDialog extends StatelessWidget {
  final Widget title;
  final EdgeInsets titlePadding;
  final List<Widget> children;
  final EdgeInsets childrenPadding;
  final Widget optionalWidget;
  final List<Widget> actions;
  final double actionsPadding;
  final EdgeInsets insetPadding;

  const DeepExpandBaseDialog(
      {this.title,
      this.titlePadding,
      this.children,
      this.childrenPadding,
      this.actions,
      this.actionsPadding,
      this.optionalWidget,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title.isNotNull)
              Padding(
                padding: titlePadding ??
                    const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                child: title,
              ),
            if (children.isNotNull)
              Flexible(
                child: ScrollConfiguration(
                  behavior: const DeepScrollBehavior(),
                  child: SingleChildScrollView(
                    padding: childrenPadding ??
                        EdgeInsets.fromLTRB(24.0, 24.0, 24.0,
                            actions.isNotNull ? (actionsPadding ?? 32.0) : 0.0),
                    child: ListBody(
                      children: children,
                    ),
                  ),
                ),
              ),
            if (optionalWidget.isNotNull) Flexible(child: optionalWidget),
            if (actions.isNotNull)
              Container(
                decoration: BoxDecoration(
                    border: Border(top: Divider.createBorderSide(context))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions,
                ),
              )
          ],
        ),
      ),
    );
  }
}
