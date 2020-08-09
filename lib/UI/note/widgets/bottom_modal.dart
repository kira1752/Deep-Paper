import 'package:deep_paper/UI/widgets/deep_scroll_behavior.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:moor/moor.dart' hide Column;

class BottomModal {
  BottomModal._();

  static Future openAddMenu({@required BuildContext context}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).canvasColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        builder: (context) {
          return ScrollConfiguration(
            behavior: DeepScrollBehavior(),
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
                      MyIcon.camera_alt_outline,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Take photo",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  child: ListTile(
                    shape: const StadiumBorder(),
                    leading: Icon(
                      MyIcon.photo_outline,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Choose image",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  child: ListTile(
                    shape: const StadiumBorder(),
                    leading: Icon(
                      Icons.mic_none,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Recording",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  child: ListTile(
                    shape: const StadiumBorder(),
                    leading: Icon(
                      MyIcon.audiotrack_outline,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Choose audio",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future openOptionsMenu({@required BuildContext context,
    @required void Function() onDelete,
    @required void Function() onCopy,
    @required void Function() noteInfo}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Theme
            .of(context)
            .canvasColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        builder: (context) {
          return ScrollConfiguration(
            behavior: DeepScrollBehavior(),
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
                      MyIcon.trash_empty,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Delete",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
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
                      Icons.content_copy,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Make a copy",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
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
                      Icons.info_outline,
                      color: Colors.white70,
                    ),
                    title: Text(
                      "Note info",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: SizeHelper.getModalButton),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
