import 'package:flutter/material.dart';

import '../../../app_theme.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: Text(
        'TASK',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: themeColorOpacity(context: context, opacity: .8),
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
