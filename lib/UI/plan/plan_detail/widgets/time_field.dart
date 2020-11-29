import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/provider/plan/create_plan_provider.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../style/app_theme.dart';
import '../../../transition/widgets/slide_downward_widget.dart';
import '../../../transition/widgets/slide_right_widget.dart';
import '../../../widgets/deep_date_picker.dart';
import '../../widgets/field_base.dart';

class TimeField extends StatelessWidget {
  const TimeField();

  @override
  Widget build(BuildContext context) {
    return Selector<CreatePlanProvider, bool>(
      selector: (context, provider) => provider.getDate.isNull,
      builder: (context, isEmpty, time) => IgnorePointer(
        ignoring: isEmpty,
        child: SlideDownwardWidget(
          reverseDuration: const Duration(milliseconds: 400),
          child: isEmpty ? const SizedBox() : time,
        ),
      ),
      child: const _Time(),
    );
  }
}

class _Time extends StatefulWidget {
  const _Time();

  @override
  __TimeState createState() => __TimeState();
}

class __TimeState extends State<_Time> {
  CreatePlanProvider _createPlanProvider;

  @override
  void initState() {
    super.initState();
    _createPlanProvider =
        Provider.of<CreatePlanProvider>(context, listen: false);
    _createPlanProvider.initiateTime =
        DateTime.now().add(const Duration(minutes: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FieldBase(
        onTap: () {
          _showTimePicker(context);
        },
        leading: Icon(
          FluentIcons.clock_alarm_24_regular,
          color: Theme.of(context).accentColor,
        ),
        title: Selector<CreatePlanProvider, String>(
            selector: (context, provider) =>
                DateFormat.jm('en_US').format(provider.getTime),
            builder: (context, time, _) => SlideRightWidget(
                  child: Text(
                    '$time',
                    key: Key('$time'),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: themeColorOpacity(context: context, opacity: .8),
                        fontSize: SizeHelper.modalTextField),
                  ),
                )),
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);

    final getDate = DateTime(
        provider.getDate.year, provider.getDate.month, provider.getDate.day);
    final now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final picked = getDate != now
        ? await openTimePicker(context)
        : await openTimePickerWithLimit(
            context,
          );

    if (picked != null) {
      provider.setTime = picked;
    }
  }
}
