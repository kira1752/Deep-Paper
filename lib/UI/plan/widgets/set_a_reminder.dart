import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/plan/provider/create_plan_provider.dart';
import '../../transition/widgets/slide_left_widget.dart';

class SetAReminder extends StatelessWidget {
  const SetAReminder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'SET A REMINDER',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white.withOpacity(.80),
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          const Spacer(),
          const _DeleteButton()
        ],
      ),
    );
  }
}

class _DeleteButton extends StatefulWidget {
  const _DeleteButton();

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
      builder: (context, isEmpty, deleteButton) => IgnorePointer(
        ignoring: isEmpty,
        child: SlideLeftWidget(
            reverseDuration: const Duration(milliseconds: 400),
            child: isEmpty ? const SizedBox() : deleteButton),
      ),
      child: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: InkWell(
            onTap: () {
              _createPlanProvider.setDate = '';
            },
            splashColor: Theme.of(context).accentColor.withOpacity(0.16),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'DELETE',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      letterSpacing: 1.2,
                      color: Theme.of(context).accentColor.withOpacity(0.80),
                    ),
              ),
            ),
          )),
    );
  }
}
