import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../icons/my_icon.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../transition/widgets/slide_downward_widget.dart';
import '../../transition/widgets/slide_right_widget.dart';
import 'field_base.dart';

class TimeField extends StatelessWidget {
  const TimeField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Selector<CreatePlanProvider, bool>(
        selector: (context, provider) => provider.getDate.isEmpty,
        builder: (context, isEmpty, time) => IgnorePointer(
          ignoring: isEmpty,
          child: SlideDownwardWidget(
            reverseDuration: const Duration(milliseconds: 400),
            child: isEmpty ? const SizedBox() : time,
          ),
        ),
        child: const _Time(),
      ),
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_createPlanProvider.getTime.isEmpty) {
      _createPlanProvider.initiateTime =
          const TimeOfDay(hour: 9, minute: 0).format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FieldBase(
      onTap: () {
        _showTimePicker(context);
      },
      leading: Icon(
        MyIcon.clock,
        color: themeColorOpacity(context: context, opacity: .7),
      ),
      title: Selector<CreatePlanProvider, String>(
          selector: (context, provider) => provider.getTime,
          builder: (context, time, _) => SlideRightWidget(
                child: Text(
                  '$time',
                  key: Key('$time'),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: themeColorOpacity(context: context, opacity: .8),
                      fontSize: SizeHelper.getModalTextField),
                ),
              )),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, widget) {
        return widget;
      },
    );

    if (picked != null) provider.setTime = picked.format(context);
  }
}
