import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/note/provider/fab_provider.dart';
import 'create_plan.dart' as create_plan;
import 'widgets/appbar/plan_default_appbar.dart';
import 'widgets/empty_plan_illustration.dart';

class PlanPage extends StatelessWidget {
  const PlanPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PlanDefaultAppBar(),
      body: EmptyPlanIllustration(),
      floatingActionButton: RepaintBoundary(
        child: _AnimateFABScroll(
          fab: _PlanFAB(),
        ),
      ),
    );
  }
}

class _AnimateFABScroll extends StatelessWidget {
  const _AnimateFABScroll({@required this.fab});

  final Widget fab;

  @override
  Widget build(BuildContext context) {
    final isNotVisible =
        context.select((FABProvider value) => value.getScrollDown);

    return AnimatedAlign(
      alignment:
          isNotVisible ? const Alignment(1.5, 1.0) : Alignment.bottomRight,
      duration: const Duration(milliseconds: 350),
      curve: isNotVisible ? Curves.easeIn : Curves.easeOut,
      child: IgnorePointer(
        ignoring: isNotVisible,
        child: fab,
      ),
    );
  }
}

class _PlanFAB extends StatelessWidget {
  const _PlanFAB();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      splashColor: Theme
          .of(context)
          .accentColor
          .withOpacity(0.16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: const Icon(
        FluentIcons.add_28_filled,
        color: Colors.white,
      ),
      onPressed: () {
        create_plan.show(context: context);
      },
    );
  }
}
