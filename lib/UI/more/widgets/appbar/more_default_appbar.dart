import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';

class MoreDefaultAppBar extends StatelessWidget {
  const MoreDefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: Text(
        'MORE',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontSize: SizeHelper.getTitle),
      ),
    );
  }
}
