import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class FinanceDefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text(
        "FINANCE",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: SizeHelper.getHeadline5),
      ),
    );
  }
}
