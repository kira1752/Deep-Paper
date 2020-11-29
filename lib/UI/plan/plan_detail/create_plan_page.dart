import 'package:flutter/material.dart';

import '../../../utility/size_helper.dart';
import '../../../utility/sizeconfig.dart';
import '../../style/app_theme.dart';
import 'widgets/add_task_button.dart';
import 'widgets/date_field.dart';
import 'widgets/plan_name_field.dart';
import 'widgets/repeat_field.dart';
import 'widgets/set_reminder_title.dart';
import 'widgets/task_title.dart';
import 'widgets/time_field.dart';

class CreatePlanPage extends StatelessWidget {
  const CreatePlanPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: SizeConfig.safeArea.top + 40, bottom: 8.0),
            color: Theme.of(context).cardColor,
            child: Container(
              height: 8,
              width: 48,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(.54),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 32.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.all(Radius.circular(24.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: CustomScrollView(
                        cacheExtent: 100,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          const SliverList(
                            delegate: SliverChildListDelegate.fixed([
                              PlanNameField(),
                              SetReminderTitle(),
                              DateField(),
                              TimeField(),
                              RepeatField(),
                              TaskTitle()
                            ]),
                          ),
                          SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            return const AddTaskButton();
                          }, childCount: 1))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(top: Divider.createBorderSide(context))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FlatButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24.0))),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textColor: themeColorOpacity(
                                  context: context, opacity: .87),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeHelper.modalButton,
                                ),
                              )),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: Divider.createBorderSide(
                              context,
                            ))),
                            child: FlatButton(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(24.0))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                textColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(.87),
                                onPressed: () {},
                                child: const Text(
                                  'Create',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: SizeHelper.modalButton,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
