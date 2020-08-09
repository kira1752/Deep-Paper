import 'package:deep_paper/UI/plan/plan_detail/create_plan.dart';
import 'package:deep_paper/UI/plan/widgets/appbar/plan_default_appbar.dart';
import 'package:deep_paper/UI/plan/widgets/empty_plan_illustration.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: PlanDefaultAppBar()),
      body: EmptyPlanIllustration(),
      floatingActionButton: PlanFloatingActionButton(
        mainContext: context,
      ),
    );
  }
}

class PlanFloatingActionButton extends StatelessWidget {
  final BuildContext mainContext;

  PlanFloatingActionButton({@required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Selector<FABProvider, bool>(
          selector: (context, provider) => provider.getScrollDown,
          builder: (context, isVisible, widget) {
            return AnimatedAlign(
              alignment:
                  isVisible ? Alignment(1.0, 1.5) : Alignment.bottomRight,
              duration: Duration(milliseconds: 350),
              curve: isVisible ? Curves.easeIn : Curves.easeOut,
              child: FloatingActionButton.extended(
                heroTag: null,
                splashColor: Theme.of(context).accentColor.withOpacity(0.16),
                icon: Icon(
                  MyIcon.edit_outline,
                  color: Theme.of(context).accentColor,
                ),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Write a plan",
                    style: Theme.of(context).textTheme.button.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.80)),
                  ),
                ),
                onPressed: () {
                  CreatePlan.show(mainContext: mainContext, context: context);
                },
              ),
            );
          }),
    );
  }
}
