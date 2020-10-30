import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../widgets/modal_field.dart';

Future openAddMenu({@required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).canvasColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
    builder: (context) => ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18.0),
      children: const <Widget>[
        ModalField(icon: FluentIcons.camera_24_regular, title: 'Take photo'),
        ModalField(icon: FluentIcons.image_24_regular, title: 'Choose image'),
        ModalField(icon: FluentIcons.mic_on_24_regular, title: 'Recording'),
        ModalField(icon: FluentIcons.music_24_regular, title: 'Choose audio')
      ],
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
    builder: (context) => ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18.0),
      children: <Widget>[
        ModalField(
          icon: FluentIcons.delete_24_regular,
          title: 'Delete',
          onTap: onDelete,
        ),
        ModalField(
          icon: FluentIcons.copy_24_regular,
          title: 'Make a copy',
          onTap: onCopy,
        ),
        ModalField(
          icon: FluentIcons.info_24_regular,
          title: 'Note info',
          onTap: noteInfo,
        ),
      ],
    ),
  );
}
