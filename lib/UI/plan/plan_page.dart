import 'package:deep_paper/UI/plan/widgets/appbar/plan_default_appbar.dart';
import 'package:deep_paper/UI/plan/widgets/empty_plan_illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: PlanDefaultAppBar()),
      body: EmptyPlanIllustration(),
      floatingActionButton: PlanFloatingActionButton(),
    );
  }
}

class PlanFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Create plan",
      backgroundColor: Theme.of(context).accentColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 32.0,
      ),
      onPressed: () {},
    );
  }
}
