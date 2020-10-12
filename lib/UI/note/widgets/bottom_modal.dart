import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

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
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          Material(
            color: Colors.transparent,
            shape: const StadiumBorder(),
            child: ListTile(
              shape: const StadiumBorder(),
              leading: Icon(
                FluentIcons.camera_24_filled,
                color: Theme.of(context).accentColor.withOpacity(.87),
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
                FluentIcons.image_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
              ),
              title: Text(
                'Choose image',
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
                FluentIcons.mic_on_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
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
                FluentIcons.music_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
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

Future openOptionsMenu({@required BuildContext context,
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
                FluentIcons.delete_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
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
                FluentIcons.copy_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
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
                FluentIcons.info_24_filled,
                color: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(.87),
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
