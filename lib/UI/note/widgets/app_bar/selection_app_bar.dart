import 'package:deep_paper/UI/apptheme.dart';
import 'package:deep_paper/UI/note/widgets/menu_app_bar/selection_menu.dart';
import 'package:deep_paper/bussiness_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/bussiness_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/resource/icon_resource.dart';
import 'package:deep_paper/resource/string_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NormalSelectionAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: IconResource.darkClose,
          onPressed: () {
            Provider.of<DeepBottomProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .setSelection = false;
            Provider.of<SelectionProvider>(context, listen: false)
                .getSelected
                .clear();
          }),
      actions: <Widget>[
        SelectionMenu(),
      ],
      title: Selector<SelectionProvider, int>(
        builder: (context, count, child) {
          return Text(StringResource.selectionAppBar(count),
              style: AppTheme.darkTitleSelectionAppBar(context));
        },
        selector: (context, provider) => provider.getSelected.length,
      ),
    );
  }
}
