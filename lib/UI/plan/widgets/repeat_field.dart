import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../icons/my_icon.dart';
import '../../../utility/extension.dart';
import '../../../utility/size_helper.dart';
import '../../transition/widgets/slide_downward_widget.dart';
import '../../transition/widgets/slide_right_widget.dart';
import '../utility/repeat_type.dart';
import 'dialog/plan_dialog.dart' as plan_dialog;
import 'field_base.dart';

class RepeatField extends StatelessWidget {
  const RepeatField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Selector<CreatePlanProvider, bool>(
          selector: (context, provider) => provider.getDate.isEmpty,
          child: const SizedBox(),
          builder: (context, isEmpty, emptyState) => IgnorePointer(
                ignoring: isEmpty,
                child: SlideDownwardWidget(
                  reverseDuration: const Duration(milliseconds: 400),
                  child: isEmpty ? emptyState : const _Repeat(),
                ),
              )),
    );
  }
}

class _Repeat extends StatefulWidget {
  const _Repeat();

  @override
  __RepeatState createState() => __RepeatState();
}

class __RepeatState extends State<_Repeat> {
  CreatePlanProvider _createPlanProvider;

  @override
  void initState() {
    super.initState();
    _createPlanProvider =
        Provider.of<CreatePlanProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FieldBase(
      onTap: () {
        plan_dialog.openRepeatDialog(
            context: context, createPlanProvider: _createPlanProvider);
      },
      leading: const Icon(
        MyIcon.repeat,
        color: Colors.white70,
      ),
      title: Selector<CreatePlanProvider, String>(
          selector: (context, provider) => provider.getRepeatTitle,
          builder: (context, repeatTitle, _) => SlideRightWidget(
                child: Text(
                  '$repeatTitle',
                  key: Key('$repeatTitle'),
                  overflow: TextOverflow.ellipsis,
                  style: _createPlanProvider.getRepeat == RepeatType.Weekly
                      ? Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).accentColor.withOpacity(.80),
                          fontSize: SizeHelper.getModalTextField)
                      : Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white.withOpacity(.80),
                          fontSize: SizeHelper.getModalTextField),
                ),
              )),
      subtitle: Selector<CreatePlanProvider, String>(
          selector: (context, provider) => provider.getSelectedDaysTitle,
          child: const SizedBox(),
          builder: (context, repeatDays, emptyState) =>
              SlideRightWidget(
                child: repeatDays.isEmpty
                    ? emptyState
                    : Padding(
                  key: Key('$repeatDays'),
                  padding: const EdgeInsetsDirectional.only(top: 6.0),
                  child: Text(
                    '$repeatDays',
                    maxLines: null,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(
                        color: Colors.white60,
                        fontSize: SizeHelper.getBodyText2),
                  ),
                ),
              )),
      trailing: Selector<CreatePlanProvider, bool>(
        selector: (context, provider) => provider.getRepeat.isNotNull,
        builder: (context, valueExist, cancelIcon) =>
        valueExist ? cancelIcon : const SizedBox(),
        child: IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.white60,
            ),
            onPressed: () {
              _createPlanProvider.setRepeat = null;
              _createPlanProvider.setRepeatTitle = 'Repeat';
              _createPlanProvider.setRepeatDialogType = 'days';
              _createPlanProvider.setSelectedDaysTitle = '';
              _createPlanProvider.setNumberOfRepeat = 1;
              _createPlanProvider.setSelectedDays = [];
              _createPlanProvider.setWeekDays = [
                false, // Sunday
                true, // Monday
                false, // Tuesday
                false, // Wednesday
                false, // Thursday
                false, // Friday
                false, // Saturday
              ];
            }),
      ),
    );
  }
}
