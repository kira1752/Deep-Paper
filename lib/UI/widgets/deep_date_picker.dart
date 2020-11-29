import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/string_resource.dart';
import '../../utility/size_helper.dart';
import '../style/app_theme.dart';
import 'deep_scroll_behavior.dart';

class DeepDatePicker extends StatefulWidget {
  const DeepDatePicker(
      {@required this.title,
      @required this.mode,
      @required this.restriction,
      @required this.dateTime});

  final CupertinoDatePickerMode mode;
  final String title;
  final DateTime dateTime;
  final bool restriction;

  @override
  _DeepDatePickerState createState() => _DeepDatePickerState();
}

class _DeepDatePickerState extends State<DeepDatePicker> {
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          decoration: BoxDecoration(
              border: Border(bottom: Divider.createBorderSide(context))),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeHelper.headline6,
              fontWeight: FontWeight.w600,
              color: themeColorOpacity(context: context, opacity: .87),
            ),
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: const DeepScrollBehavior(),
            child: CupertinoDatePicker(
              mode: widget.mode,
              initialDateTime: widget.dateTime,
              minimumDate: widget.restriction ? widget.dateTime : null,
              onDateTimeChanged: (DateTime value) {
                _dateTime = value;
              },
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textColor:
                        themeColorOpacity(context: context, opacity: .87),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.0))),
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: SizeHelper.modalButton,
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(left: Divider.createBorderSide(context))),
                  child: FlatButton(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textColor:
                          Theme.of(context).accentColor.withOpacity(0.87),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(24.0))),
                      onPressed: () {
                        Navigator.pop(context, _dateTime ?? widget.dateTime);
                      },
                      child: const Text(
                        'Choose',
                        style: TextStyle(
                          fontSize: SizeHelper.modalButton,
                        ),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future<DateTime> openDatePicker(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        builder: (context) => DeepDatePicker(
              title: StringResource.chooseDate,
              restriction: true,
              dateTime: DateTime.now().add(const Duration(minutes: 5)),
              mode: CupertinoDatePickerMode.date,
            ));

Future<DateTime> openTimePickerWithLimit(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        builder: (context) => DeepDatePicker(
              title: StringResource.chooseTime,
              restriction: true,
              dateTime: DateTime.now().add(const Duration(minutes: 5)),
              mode: CupertinoDatePickerMode.time,
            ));

Future<DateTime> openTimePicker(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        builder: (context) => DeepDatePicker(
              title: StringResource.chooseTime,
              restriction: false,
              dateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.time,
            ));
