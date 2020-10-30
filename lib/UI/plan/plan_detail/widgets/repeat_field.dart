import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../../../resource/string_resource.dart';
import '../../../../utility/extension.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';
import '../../../transition/widgets/slide_downward_widget.dart';
import '../../../transition/widgets/slide_right_widget.dart';
import '../../utility/repeat_type.dart';
import '../../widgets/field_base.dart';
import '../../widgets/plan_dialog.dart' as plan_dialog;

class RepeatField extends StatelessWidget {
  const RepeatField();

  @override
  Widget build(BuildContext context) {
    return Selector<CreatePlanProvider, bool>(
        selector: (context, provider) => provider.getDate.isNull,
        child: const SizedBox(),
        builder: (context, isEmpty, emptyState) => IgnorePointer(
              ignoring: isEmpty,
              child: SlideDownwardWidget(
                reverseDuration: const Duration(milliseconds: 400),
                child: isEmpty ? emptyState : const _Repeat(),
              ),
            ));
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FieldBase(
        onTap: () {
          plan_dialog.openRepeatDialog(
              context: context, createPlanProvider: _createPlanProvider);
        },
        leading: Icon(
          FluentIcons.arrow_repeat_all_24_regular,
          color: Theme.of(context).accentColor,
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
                            color: Theme.of(context).accentColor,
                            fontSize: SizeHelper.modalTextField)
                        : Theme.of(context).textTheme.bodyText1.copyWith(
                            color: themeColorOpacity(
                                context: context, opacity: .8),
                            fontSize: SizeHelper.modalTextField),
                  ),
                )),
        subtitle: Selector<CreatePlanProvider, String>(
            selector: (context, provider) => provider.getSelectedDaysTitle,
            child: const SizedBox(),
            builder: (context, repeatDays, emptyState) => SlideRightWidget(
                  child: repeatDays.isEmpty
                      ? emptyState
                      : Padding(
                          key: Key('$repeatDays'),
                          padding: const EdgeInsetsDirectional.only(top: 6.0),
                          child: Text(
                            '$repeatDays',
                            maxLines: null,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: themeColorOpacity(
                                        context: context, opacity: .7),
                                    fontSize: SizeHelper.bodyText2),
                          ),
                        ),
                )),
        trailing: Selector<CreatePlanProvider, bool>(
          selector: (context, provider) => provider.getRepeat.isNotNull,
          builder: (context, valueExist, cancelIcon) =>
              valueExist ? cancelIcon : const SizedBox(),
          child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: themeColorOpacity(context: context, opacity: .6),
              ),
              onPressed: () {
                _createPlanProvider.setRepeat = null;
                _createPlanProvider.setRepeatTitle = StringResource.noRepeat;
                _createPlanProvider.setRepeatDialogType = StringResource.days;
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
      ),
    );
  }
}
