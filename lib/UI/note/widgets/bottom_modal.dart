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
                    leading: const Icon(
                      MyIcon.camera,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Take photo',
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
                    leading: const Icon(
                      MyIcon.image,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Choose image',
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
                    leading: const Icon(
                      MyIcon.mic,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Recording',
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
                    leading: const Icon(
                      MyIcon.music,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Choose audio',
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
                    leading: const Icon(
                      MyIcon.trash_2,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Delete',
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
                    leading: const Icon(
                      MyIcon.copy,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Make a copy',
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
                    leading: const Icon(
                      MyIcon.info,
                      color: Colors.white70,
                    ),
                    title: Text(
                      'Note info',
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
