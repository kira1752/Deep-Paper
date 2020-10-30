import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/plan/provider/repeat_dialog_provider.dart';
import '../../../../utility/size_helper.dart';
import '../../../app_theme.dart';

class NumberRepeatTextField extends StatelessWidget {
  final TextEditingController controller;

  const NumberRepeatTextField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    final _repeatDialogProvider =
        Provider.of<RepeatDialogProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8.0),
      child: FittedTextFieldContainer(
        calculator: FittedTextFieldCalculator.fitVisibleWithPadding(16.0),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          showCursor: true,
          textInputAction: TextInputAction.done,
          style: Theme
              .of(context)
              .textTheme
              .bodyText1
              .copyWith(
              color: themeColorOpacity(context: context, opacity: .8),
              fontSize: SizeHelper.modalTextField),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.80))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.80))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.80))),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.80)))),
          onChanged: (value) {
            if (value.isEmpty) {
              _repeatDialogProvider.setTempNumberOfRepeat = 0;
            } else {
              _repeatDialogProvider.setTempNumberOfRepeat = int.parse(value);
            }
          },
        ),
      ),
    );
  }
}
