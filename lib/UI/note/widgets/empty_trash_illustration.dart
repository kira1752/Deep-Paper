import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/utility/illustration.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmptyTrashIllustration extends StatefulWidget {
  @override
  _EmptyTrashIllustrationState createState() => _EmptyTrashIllustrationState();
}

class _EmptyTrashIllustrationState extends State<EmptyTrashIllustration> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final drawerProvider =
          Provider.of<NoteDrawerProvider>(context, listen: false);
      drawerProvider.setTrashExist = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Illustration.getTrash,
                fit: BoxFit.contain,
                width: SizeHelper.setWidth(size: 220.0),
                height: SizeHelper.setHeight(size: 200.0),
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
        ),
      ),
    );
  }
}
