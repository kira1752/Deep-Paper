import 'package:deep_paper/UI/plan/widgets/date_field.dart';
import 'package:deep_paper/UI/plan/widgets/plan_name_field.dart';
import 'package:deep_paper/UI/plan/widgets/repeat_field.dart';
import 'package:deep_paper/UI/plan/widgets/set_a_reminder.dart';
import 'package:deep_paper/UI/plan/widgets/time_field.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class CreatePlanPage extends StatelessWidget {
  final BuildContext mainContext;

  const CreatePlanPage({@required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(mainContext).padding.top + 48,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            height: 6,
            width: 40,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(.54),
                borderRadius: BorderRadius.circular(6)),
          ),
          ScrollConfiguration(
            behavior: DeepScrollBehavior(),
            child: Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(
                    bottom: 40.0, left: 16.0, right: 16.0),
                children: [
                  const PlanNameField(),
                  const SetAReminder(),
                  const DateField(),
                  const TimeField(),
                  const RepeatField()
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border:
                    Border(top: Divider.createBorderSide(context, width: 1.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: FlatButton(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textColor: Colors.white.withOpacity(0.87),
                      onPressed: () {
                        Navigator.of(context).pop();
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
                            left:
                                Divider.createBorderSide(context, width: 1.0))),
                    child: FlatButton(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textColor:
                            Theme.of(context).accentColor.withOpacity(0.87),
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
    );
  }
}
