import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class EmptyTrashIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            Illustration.getTrash,
            width: SizeHelper.setWidth(size: 220.0),
            height: SizeHelper.setHeight(size: 200.0),
          ),
          Padding(
            padding: EdgeInsetsResponsive.only(top: 24.0),
            child: Text(
              "Your trash bin is clean",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white70,
                  fontSize: SizeHelper.getHeadline5,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
