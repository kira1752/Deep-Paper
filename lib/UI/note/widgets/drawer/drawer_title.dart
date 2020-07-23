import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  final String title;

  const DrawerTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18.0),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontSize: SizeHelper.getTitle)),
    );
  }
}
