import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/size_helper.dart';
import '../../widgets/deep_scroll_behavior.dart';
import 'date_field.dart';
import 'plan_name_field.dart';
import 'repeat_field.dart';
import 'set_a_reminder.dart';
import 'time_field.dart';

class CreatePlanPage extends StatelessWidget {
  const CreatePlanPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: Get.mediaQuery.padding.top + 40, bottom: 8.0),
          color: Theme.of(context).canvasColor,
          child: Container(
            height: 8,
            width: 48,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(.54),
                borderRadius: BorderRadius.circular(6.0)),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 32.0),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScrollConfiguration(
                  behavior: const DeepScrollBehavior(),
                  child: Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          bottom: 40.0, left: 16.0, right: 16.0),
                      children: const [
                        PlanNameField(),
                        SetAReminder(),
                        DateField(),
                        TimeField(),
                        RepeatField()
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: Divider.createBorderSide(context, width: 1.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FlatButton(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            textColor: Colors.white.withOpacity(0.87),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: SizeHelper.getModalButton,
                              ),
                            )),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  left: Divider.createBorderSide(context,
                                      width: 1.0))),
                          child: FlatButton(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.87),
                              onPressed: () {},
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: SizeHelper.getModalButton,
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
    );
  }
}
