import 'package:deep_paper/UI/plan/widgets/field_base.dart';
import 'package:deep_paper/UI/transition/widgets/slide_right_widget.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeField extends StatelessWidget {
  const TimeField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Selector<CreatePlanProvider, bool>(
          selector: (context, provider) => provider.getDate.isEmpty,
          builder: (context, isEmpty, child) => SlideRightWidget(
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 400),
                child: isEmpty ? const SizedBox() : _Time(),
              )),
    );
  }
}

class _Time extends StatefulWidget {
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
      leading: const Icon(
        MyIcon.clock,
        color: Colors.white70,
      ),
      title: Selector<CreatePlanProvider, String>(
          selector: (context, provider) => provider.getTime,
          builder: (context, time, child) {
            return SlideRightWidget(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 150),
              child: Text(
                '$time',
                key: Key('$time'),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white.withOpacity(.80),
                    fontSize: SizeHelper.getModalTextField),
              ),
            );
          }),
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
