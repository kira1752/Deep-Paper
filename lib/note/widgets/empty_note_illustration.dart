import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class EmptyNoteIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            Illustration.getNote,
            width: SizeHelper.setWidth(size: 220.0),
            height: SizeHelper.setHeight(size: 220.0),
          ),
          Padding(
            padding: EdgeInsetsResponsive.only(top: 24.0),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Never forget anything\n",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white70,
                      fontSize: SizeHelper.getHeadline5,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "Write all your important things",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white70,
                      fontSize: SizeHelper.getBodyText1,
                      fontWeight: FontWeight.w400),
                )
              ]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
