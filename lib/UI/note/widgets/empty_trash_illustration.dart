import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class EmptyTrashIllustration extends StatefulWidget {
  @override
  _EmptyTrashIllustrationState createState() => _EmptyTrashIllustrationState();
}

class _EmptyTrashIllustrationState extends State<EmptyTrashIllustration> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              Illustration.getTrash,
              fit: BoxFit.contain,
              width: SizeHelper.setWidth(size: 220.0),
              height: SizeHelper.setHeight(size: 200.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Your trash bin is clean",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white70,
                    fontSize: SizeHelper.getHeadline5,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
