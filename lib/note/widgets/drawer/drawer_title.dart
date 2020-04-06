import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  final String title;

  const DrawerTitle({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }
}
