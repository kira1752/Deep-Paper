import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';

class PlanDefaultAppBar extends StatelessWidget {
  const PlanDefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        'PLAN',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: SizeHelper.getTitle),
      ),
    );
  }
}
