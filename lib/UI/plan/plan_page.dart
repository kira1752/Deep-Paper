import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/note/provider/fab_provider.dart';
import '../../icons/my_icon.dart';
import '../../utility/size_helper.dart';
import '../app_theme.dart';
import 'plan_detail/create_plan.dart' as create_plan;
import 'widgets/appbar/plan_default_appbar.dart';
import 'widgets/empty_plan_illustration.dart';

class PlanPage extends StatelessWidget {
  const PlanPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: const PlanDefaultAppBar()),
      body: const EmptyPlanIllustration(),
      floatingActionButton: PlanFloatingActionButton(
        mainContext: context,
      ),
    );
  }
}

class PlanFloatingActionButton extends StatelessWidget {
  final BuildContext mainContext;

  const PlanFloatingActionButton({@required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Selector<FABProvider, bool>(
        selector: (context, provider) => provider.getScrollDown,
        builder: (context, isNotVisible, fab) {
          return AnimatedAlign(
            alignment: isNotVisible
                ? const Alignment(1.0, 1.5)
                : Alignment.bottomRight,
            duration: const Duration(milliseconds: 350),
            curve: isNotVisible ? Curves.easeIn : Curves.easeOut,
            child: IgnorePointer(
              ignoring: isNotVisible,
              child: fab,
            ),
          );
        },
        child: FloatingActionButton.extended(
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
            create_plan.show(context: context, mainContext: mainContext);
          },
        ),
      ),
    );
  }
}
