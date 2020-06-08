import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class PlanDefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        "PLAN",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: SizeHelper.getHeadline5),
      ),
    );
  }
}
