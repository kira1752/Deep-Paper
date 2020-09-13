import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resource/string_resource.dart';
import '../../../../utility/size_helper.dart';

class DrawerTitle extends StatelessWidget {
  const DrawerTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12.0),
      margin: const EdgeInsets.all(18.0),
      child: Text(StringResource.note,
          style:
              Get.textTheme.headline5.copyWith(fontSize: SizeHelper.getTitle)),
    );
  }
}
