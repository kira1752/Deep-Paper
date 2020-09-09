import 'package:deep_paper/UI/plan/widgets/field_base.dart';
import 'package:deep_paper/UI/transition/widgets/slide_right_widget.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
        leading: const Icon(MyIcon.calendar_1, color: Colors.white70),
        title: Selector<CreatePlanProvider, bool>(
            selector: (context, provider) => provider.getDate.isEmpty,
            builder: (context, isEmpty, child) => SlideRightWidget(
                  duration: const Duration(milliseconds: 400),
                  child: isEmpty
                      ? Text(
                          'Set date',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white.withOpacity(.80),
                              fontSize: SizeHelper.getModalTextField),
                        )
                      : Selector<CreatePlanProvider, String>(
                          selector: (context, provider) => provider.getDate,
                          builder: (context, date, child) {
                            return SlideRightWidget(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 150),
                              child: Text(
                                '$date',
                                key: Key('$date'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.white.withOpacity(.80),
                                        fontSize: SizeHelper.getModalTextField),
                              ),
                            );
                          }),
                )),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder: (context, widget) {
        return widget;
      },
    );

    if (picked != null) {
      provider.setDate = DateFormat.yMMMd('en_US').format(picked);
    }
  }
}
