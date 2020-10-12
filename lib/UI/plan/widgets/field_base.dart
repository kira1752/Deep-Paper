import 'package:flutter/material.dart';

import '../../../utility/extension.dart';

class FieldBase extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets paddingLeading;
  final EdgeInsets paddingContent;
  final EdgeInsets paddingTrailing;
  final Function onTap;

  const FieldBase(
      {@required this.onTap,
      @required this.leading,
      @required this.title,
      this.subtitle,
      this.trailing,
      this.paddingLeading,
      this.paddingContent,
      this.paddingTrailing});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Theme.of(context).accentColor.withOpacity(.16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: paddingLeading ??
                  const EdgeInsetsDirectional.only(
                      start: 16.0, end: 32.0, top: 16.0, bottom: 16.0),
              child: leading,
            ),
            Expanded(
              child: Padding(
                padding: paddingContent ??
                    const EdgeInsetsDirectional.only(top: 16.0, bottom: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [title, if (subtitle.isNotNull) subtitle],
                ),
              ),
            ),
            if (trailing.isNotNull)
              Padding(
                padding: paddingTrailing ??
                    const EdgeInsetsDirectional.only(end: 8.0),
                child: trailing,
              )
          ],
        ),
      ),
    );
  }
}
