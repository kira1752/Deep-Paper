import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:moor/moor.dart' hide Column;

import '../../../icons/my_icon.dart';
import '../../../utility/size_helper.dart';
import '../../widgets/deep_scroll_behavior.dart';

// BottomModal Utility class
class BottomModal {
  BottomModal._();

  static Future openAddMenu() {
    return Get.bottomSheet(
      ScrollConfiguration(
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
                leading: const Icon(
                  MyIcon.camera,
                  color: Colors.white70,
                ),
                title: Text(
                  'Take photo',
                  style: Get.textTheme.bodyText1
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
                  style: Get.textTheme.bodyText1
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
                  style: Get.textTheme.bodyText1
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
                  style: Get.textTheme.bodyText1
                      .copyWith(fontSize: SizeHelper.getModalButton),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Get.theme.canvasColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
    );
  }

  static Future openOptionsMenu(
      {@required void Function() onDelete,
      @required void Function() onCopy,
      @required void Function() noteInfo}) {
    return Get.bottomSheet(
      ScrollConfiguration(
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
                leading: const Icon(
                  MyIcon.trash,
                  color: Colors.white70,
                ),
                title: Text(
                  'Delete',
                  style: Get.textTheme.bodyText1
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
                  style: Get.textTheme.bodyText1
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
                  style: Get.textTheme.bodyText1
                      .copyWith(fontSize: SizeHelper.getModalButton),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Get.theme.canvasColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
    );
  }
}
