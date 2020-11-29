import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';

class DrawerTotalNotes extends StatelessWidget {
  const DrawerTotalNotes(this.total);

  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Text(
          '$total',
          style: TextStyle(
              color: themeColorOpacity(context: context, opacity: .54),
              fontSize: SizeHelper.bodyText1,
              fontWeight: FontWeight.w600),
        ));
  }
}
