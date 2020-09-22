import 'package:flutter/material.dart';

import '../../../app_theme.dart';

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
        style: appBarStyle(context: context),
      ),
    );
  }
}
