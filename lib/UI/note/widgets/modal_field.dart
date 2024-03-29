import 'package:flutter/material.dart';

import '../../../utility/size_helper.dart';
import '../../style/app_theme.dart';

class ModalField extends StatelessWidget {
  const ModalField(
      {@required this.icon,
      @required this.title,
      this.fontSize = SizeHelper.modalButton,
      this.onTap});

  final String title;
  final IconData icon;
  final double fontSize;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const StadiumBorder(),
      child: ListTile(
        shape: const StadiumBorder(),
        onTap: onTap,
        leading: Icon(
          icon,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: themeColorOpacity(context: context, opacity: .7),
              fontSize: fontSize),
        ),
      ),
    );
  }
}
