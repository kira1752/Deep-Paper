import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/note/provider/fab_provider.dart';
import '../../icons/my_icon.dart';
import '../app_theme.dart';
import 'plan_detail/create_plan.dart' as create_plan;
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
      floatingActionButton: _AnimateFABScroll(
        fab: _PlanFAB(),
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
          isNotVisible ? const Alignment(1.0, 1.5) : Alignment.bottomRight,
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
    return FloatingActionButton.extended(
      heroTag: null,
      splashColor: Theme.of(context).accentColor.withOpacity(0.16),
      icon: Icon(
        MyIcon.edit_3,
        color: Theme.of(context).accentColor,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Write a plan',
          style: Theme.of(context).textTheme.button.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                color: themeColorOpacity(context: context, opacity: .8),
              ),
        ),
      ),
      onPressed: () {
        create_plan.show(context: context);
      },
    );
  }
}
