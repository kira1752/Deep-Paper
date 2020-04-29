import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/note/business_logic/note_creation.dart';
import 'package:deep_paper/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/note/provider/selection_provider.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class NormalSelectionAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.close),
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
        PopupMenuButton(
            tooltip: "Open Selection Menu",
            padding: EdgeInsetsResponsive.all(18),
            onSelected: (choice) {
              _onNormalSelected(context: context, choice: choice);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        leading: Icon(MyIcon.trash_empty,
                            color: Colors.white.withOpacity(0.60)),
                        title: Text(
                          "Delete",
                          style: TextStyle(fontSize: SizeHelper.getBodyText1),
                        ),
                      )),
                  PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(
                          MyIcon.move_to,
                          color: Colors.white.withOpacity(0.60),
                        ),
                        title: Text(
                          "Move to",
                          style: TextStyle(fontSize: SizeHelper.getBodyText1),
                        ),
                      ))
                ]),
      ],
      elevation: 0.0,
      centerTitle: true,
      title: Selector<SelectionProvider, int>(
        builder: (context, count, child) {
          debugPrintSynchronously("Text Title rebuilt");
          return Text('$count selected',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: SizeHelper.getHeadline5));
        },
        selector: (context, provider) => provider.getSelected.length,
      ),
    );
  }

  Future<void> _onNormalSelected(
      {@required BuildContext context, @required int choice}) async {
    debugPrintSynchronously("$choice");
    switch (choice) {
      case 0:
        NoteCreation.moveToTrashBatch(context: context);
        Provider.of<DeepBottomProvider>(context, listen: false).setSelection =
            false;
        Provider.of<SelectionProvider>(context, listen: false).setSelection =
            false;

        Provider.of<SelectionProvider>(context, listen: false)
            .getSelected
            .clear();
        break;
      default:
    }
  }
}
