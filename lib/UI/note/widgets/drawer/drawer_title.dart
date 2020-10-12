import 'package:flutter/material.dart';

import '../../../../resource/string_resource.dart';
import '../../../app_theme.dart' as app_theme;

class DrawerTitle extends StatelessWidget {
  const DrawerTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 12.0),
        margin: const EdgeInsets.all(18.0),
        child: Text(
          StringResource.note,
          style: app_theme.noteDrawerTitle(context: context),
        ));
  }
}
