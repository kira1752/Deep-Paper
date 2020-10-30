import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../utility/size_helper.dart';
import '../app_theme.dart';

void showSnack(
    {@required BuildContext context,
    @required Icon icon,
    @required String description}) {
  showSimpleNotification(
      Text(
        '$description',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: SizeHelper.bodyText1,
              color: themeColorOpacity(context: context, opacity: .7),
            ),
      ),
      background: Theme.of(context).dialogBackgroundColor,
      leading: icon,
      duration: const Duration(seconds: 3),
      slideDismiss: true);
}
