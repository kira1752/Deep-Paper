import 'package:flutter/material.dart';

import '../../../style/app_theme.dart';

class MoreDefaultAppBar extends StatelessWidget {
  const MoreDefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text(
        'More',
        style: appBarStyle(context: context),
      ),
    );
  }
}
