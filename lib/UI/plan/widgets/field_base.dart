import 'package:flutter/material.dart';

import '../../../utility/extension.dart';

class FieldBase extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsetsGeometry paddingLeading;
  final EdgeInsetsGeometry paddingContent;
  final EdgeInsetsGeometry paddingTrailing;
  final Function onTap;

  const FieldBase(
      {@required this.onTap,
      @required this.leading,
      @required this.title,
      this.subtitle,
      this.trailing,
      this.paddingLeading = const EdgeInsetsDirectional.only(
          start: 16.0, end: 32.0, top: 16.0, bottom: 16.0),
      this.paddingContent =
          const EdgeInsetsDirectional.only(top: 16.0, bottom: 16.0),
      this.paddingTrailing = const EdgeInsetsDirectional.only(end: 10.0)});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        splashColor: Theme
            .of(context)
            .accentColor
            .withOpacity(.16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: paddingLeading,
              child: Material(
                  color: Theme
                      .of(context)
                      .accentColor
                      .withOpacity(.12),
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: leading,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: paddingContent,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [title, if (subtitle.isNotNull) subtitle],
                ),
              ),
            ),
            if (trailing.isNotNull)
              Padding(
                padding: paddingTrailing,
                child: trailing,
              )
          ],
        ),
      ),
    );
  }
}
