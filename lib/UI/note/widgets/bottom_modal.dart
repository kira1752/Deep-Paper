import 'package:flutter/material.dart';

import '../../../icons/my_icon.dart';
import '../../../utility/size_helper.dart';
import '../../app_theme.dart';
import '../../widgets/deep_scroll_behavior.dart';

Future openAddMenu({@required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).canvasColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
    builder: (context) => ScrollConfiguration(
      behavior: const DeepScrollBehavior(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: Icon(
                MyIcon.camera,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Take photo',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: Icon(
                MyIcon.image,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Choose image',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: Icon(
                MyIcon.mic,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Recording',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: Icon(
                MyIcon.music,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Choose audio',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Future openOptionsMenu(
    {@required BuildContext context,
    @required void Function() onDelete,
    @required void Function() onCopy,
    @required void Function() noteInfo}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).canvasColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
    builder: (context) => ScrollConfiguration(
      behavior: const DeepScrollBehavior(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              onTap: onDelete,
              leading: Icon(
                MyIcon.trash,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Delete',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              onTap: onCopy,
              leading: Icon(
                MyIcon.copy,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Make a copy',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              onTap: noteInfo,
              leading: Icon(
                MyIcon.info,
                color: themeColorOpacity(context: context, opacity: .7),
              ),
              title: Text(
                'Note info',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(
                    color: themeColorOpacity(context: context, opacity: .7),
                    fontSize: SizeHelper.getModalButton),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
