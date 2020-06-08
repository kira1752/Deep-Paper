import 'package:deep_paper/plan/widgets/appbar/plan_default_appbar.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
          child: PlanDefaultAppBar()),
    );
  }
}