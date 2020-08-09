import 'package:deep_paper/UI/transition/widgets/slide_left_widget.dart';
import 'package:deep_paper/UI/transition/widgets/slide_right_widget.dart';
import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/business_logic/note/provider/detect_text_direction_provider.dart';
import 'package:deep_paper/business_logic/note/provider/text_controller_provider.dart';
import 'package:deep_paper/business_logic/plan/provider/create_plan_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

class CreatePlan {
  static Future<void> show(
      {@required BuildContext context, @required BuildContext mainContext}) {
    final _mainContext = mainContext;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return _CreatePlanPage(
            mainContext: _mainContext,
          );
        });
  }
}

class _CreatePlanPage extends StatefulWidget {
  final BuildContext mainContext;

  _CreatePlanPage({@required this.mainContext});

  @override
  __CreatePlanPageState createState() => __CreatePlanPageState();
}

class __CreatePlanPageState extends State<_CreatePlanPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreatePlanProvider(),
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(widget.mainContext).padding.top + 48,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
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
                  physics: ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  children: [
                    _PlanNameField(),
                    _SetAReminder(),
                    _DateField(),
                    _TimeField()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: MultiProvider(
        providers: [
          Provider<TextControllerProvider>(
            create: (context) => TextControllerProvider(),
            dispose: (context, provider) => provider.controller.dispose(),
          ),
          ChangeNotifierProvider(
              create: (context) => DetectTextDirectionProvider())
        ],
        child: Consumer<TextControllerProvider>(
            builder: (context, textControllerProvider, child) {
          return Selector<DetectTextDirectionProvider, TextDirection>(
              selector: (context, provider) =>
                  provider.getDirection ? TextDirection.rtl : TextDirection.ltr,
              builder: (context, direction, child) {
                return TextField(
                  controller: textControllerProvider.controller,
                  textDirection: direction,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white70, fontSize: SizeHelper.getPlanTitle),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'My plan is...',
                  ),
                );
              });
        }),
      ),
    );
  }
}

class _SetAReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "SET A REMINDER",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white.withOpacity(.80),
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          Spacer(),
          _DeleteButton()
        ],
      ),
    );
  }
}

class _DeleteButton extends StatefulWidget {
  @override
  __DeleteButtonState createState() => __DeleteButtonState();
}

class __DeleteButtonState extends State<_DeleteButton> {
  CreatePlanProvider _createPlanProvider;

  @override
  void initState() {
    super.initState();
    _createPlanProvider =
        Provider.of<CreatePlanProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CreatePlanProvider, bool>(
        selector: (context, provider) => provider.getDate.isEmpty,
        child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(12.0))),
            child: InkWell(
              onTap: () {
                _createPlanProvider.setDate = "";
              },
              splashColor: Theme.of(context).accentColor.withOpacity(0.16),
              borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "DELETE",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        letterSpacing: 1.2,
                        color: Theme.of(context).accentColor.withOpacity(0.80),
                      ),
                ),
              ),
            )),
        builder: (context, isEmpty, deleteButton) =>
            SlideLeftWidget(child: isEmpty ? SizedBox.shrink() : deleteButton));
  }
}

class _DateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Selector<CreatePlanProvider, bool>(
        selector: (context, provider) => provider.getDate.isEmpty,
        builder: (context, isEmpty, child) => Material(
          color: Theme.of(context).accentColor.withOpacity(.08),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
          ),
          child: ListTile(
            onTap: () {
              _showDatePicker(context);
              // Below line stops keyboard from appearing
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).accentColor.withOpacity(0.38)),
              borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
            ),
            leading: Icon(Icons.event, color: Colors.white70),
            title: isEmpty
                ? Text(
                    "Set date",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.white.withOpacity(.80),
                        fontSize: SizeHelper.getModalTextField),
                  )
                : Selector<CreatePlanProvider, String>(
                    selector: (context, provider) => provider.getDate,
                    builder: (context, date, child) {
                      return Text(
                        "$date",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white.withOpacity(.80),
                            fontSize: SizeHelper.getModalTextField),
                      );
                    }),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 730)),
      builder: (context, widget) {
        return widget;
      },
    );

    if (picked != null)
      provider.setDate = DateFormat.yMMMd("en_US").format(picked);
  }
}

class _TimeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Selector<CreatePlanProvider, bool>(
          selector: (context, provider) => provider.getDate.isEmpty,
          builder: (context, isEmpty, child) => SlideRightWidget(
                child: isEmpty ? SizedBox.shrink() : _Time(),
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
          TimeOfDay(hour: 9, minute: 0).format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).accentColor.withOpacity(.08),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
      ),
      child: ListTile(
        onTap: () {
          _showTimePicker(context);
          // Below line stops keyboard from appearing
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).accentColor.withOpacity(0.38)),
          borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
        ),
        leading: Icon(
          Icons.access_time,
          color: Colors.white70,
        ),
        title: Selector<CreatePlanProvider, String>(
            selector: (context, provider) => provider.getTime,
            builder: (context, time, child) {
              return Text(
                "$time",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white.withOpacity(.80),
                    fontSize: SizeHelper.getModalTextField),
              );
            }),
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final provider = Provider.of<CreatePlanProvider>(context, listen: false);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, widget) {
        return widget;
      },
    );

    if (picked != null) provider.setTime = picked.format(context);
  }
}
