import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../transition/widgets/slide_right_widget.dart';
import '../../../widgets/deep_date_picker.dart';
import '../../widgets/field_base.dart';

class DateField extends StatelessWidget {
  const DateField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FieldBase(
        onTap: () {
          _showDatePicker(context);
        },
        leading: Icon(
          FluentIcons.calendar_24_regular,
          color: Theme.of(context).accentColor,
        ),
        title: Selector<CreatePlanProvider, bool>(
          selector: (context, provider) => provider.getDate.isNull,
          builder: (context, isEmpty, date) =>
              SlideRightWidget(
                child: isEmpty
                    ? Text(
                  'Set date',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(
                      color: themeColorOpacity(context: context, opacity: .8),
                      fontSize: SizeHelper.modalTextField),
                )
                    : date,
              ),
          child: Selector<CreatePlanProvider, String>(
              selector: (context, provider) =>
                  DateFormat.yMMMd('en_US').format(provider.getDate),
              builder: (context, date, _) =>
                  SlideRightWidget(
                    child: Text(
                      '$date',
                      key: Key('$date'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(
                          color:
                          themeColorOpacity(context: context, opacity: .8),
                          fontSize: SizeHelper.modalTextField),
                    ),
                  )),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);
    final picked = await openDatePicker(context);

    if (picked != null) {
      provider.setDate = picked;
    }
  }
}
