import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../widgets/field_base.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton();

  @override
  Widget build(BuildContext context) {
    return FieldBase(
        onTap: () {},
        leading: Icon(
          FluentIcons.add_24_regular,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          'Add a task',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: themeColorOpacity(context: context, opacity: .8),
              fontSize: SizeHelper.modalTextField),
        ));
  }
}
