import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTitle extends StatelessWidget {
  final String title;

  const DrawerTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12.0),
      margin: const EdgeInsets.all(18.0),
      child: Text(title,
          style:
              Get.textTheme.headline5.copyWith(fontSize: SizeHelper.getTitle)),
    );
  }
}
