import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

import '../../apptheme.dart';

class CreatePlanPage extends StatefulWidget {
  @override
  _CreatePlanPageState createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor.withOpacity(0.80),
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          "Create Plan",
          style: AppTheme.darkTitleAppBar(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(18, 16, 16, 16),
        child: ListBody(
          children: [_PlanNameField()],
        ),
      ),
    );
  }
}

class _PlanNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.white.withOpacity(0.80),
          fontWeight: FontWeight.normal,
          fontSize: SizeHelper.getTitle),
      maxLines: null,
      decoration: InputDecoration.collapsed(
          hintText: 'Write your plan name here...',
          hintStyle: TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
