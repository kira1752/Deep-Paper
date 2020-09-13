import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';

class FinanceDefaultAppBar extends StatelessWidget {
  const FinanceDefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text(
        'FINANCE',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: SizeHelper.getTitle),
      ),
    );
  }
}
