import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class PlanDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlanDefaultAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        'Plan',
        style: Theme.of(context).textTheme.headline5.copyWith(
            color: themeColorOpacity(context: context, opacity: .8),
            fontSize: SizeHelper.title),
      ),
    );
  }
}
