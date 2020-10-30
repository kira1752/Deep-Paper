import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size_helper.dart';
import '../app_theme.dart';
import 'deep_scroll_behavior.dart';

class DeepDatePicker extends StatefulWidget {
  const DeepDatePicker({@required this.mode, @required this.minimumDate});

  final CupertinoDatePickerMode mode;
  final bool minimumDate;

  @override
  _DeepDatePickerState createState() => _DeepDatePickerState();
}

class _DeepDatePickerState extends State<DeepDatePicker> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
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
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.all(Radius.circular(24.0))),
            child: Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const DeepScrollBehavior(),
                    child: CupertinoDatePicker(
                      mode: widget.mode,
                      minimumDate: widget.minimumDate ? DateTime.now() : null,
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
                            textColor: themeColorOpacity(
                                context: context, opacity: .87),
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
                              border: Border(
                                  left: Divider.createBorderSide(context))),
                          child: FlatButton(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textColor: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.87),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(24.0))),
                              onPressed: () {
                                Navigator.pop(context, _dateTime);
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
            ),
          ),
        ),
      ],
    );
  }
}

Future<DateTime> openDatePicker(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const DeepDatePicker(
              minimumDate: true,
              mode: CupertinoDatePickerMode.date,
            ));

Future<DateTime> openTimePickerWithLimit(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const DeepDatePicker(
              minimumDate: true,
              mode: CupertinoDatePickerMode.time,
            ));

Future<DateTime> openTimePicker(BuildContext context) =>
    showModalBottomSheet<DateTime>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const DeepDatePicker(
              minimumDate: false,
              mode: CupertinoDatePickerMode.time,
            ));
