import 'package:deep_paper/UI/note/widgets/app_bar/note_default_app_bar.dart';
import 'package:deep_paper/UI/note/widgets/build_body.dart';
import 'package:deep_paper/UI/note/widgets/drawer/deep_drawer.dart';
import 'package:deep_paper/business_logic/note/provider/deep_bottom_provider.dart';
import 'package:deep_paper/business_logic/note/provider/fab_provider.dart';
import 'package:deep_paper/business_logic/note/provider/note_drawer_provider.dart';
import 'package:deep_paper/business_logic/note/provider/selection_provider.dart';
import 'package:deep_paper/data/deep.dart';
import 'package:deep_paper/icons/my_icon.dart';
import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitSelectionOrExitApp(context);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: DeepDrawer(key: Key("Note Drawer")),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
              child: NoteDefaultAppBar()),
          floatingActionButton: Selector<SelectionProvider, bool>(
              selector: (context, selectionProvider) =>
                  !selectionProvider.getSelection,
              builder: (context, selection, child) {
                return Visibility(
                    visible: selection, child: NoteFloatingActionButton());
              }),
          body: BuildBody()),
    );
  }

  Future<bool> exitSelectionOrExitApp(BuildContext context) async {
    final providerSelection =
        Provider.of<SelectionProvider>(context, listen: false);
    final providerDeepBottom =
        Provider.of<DeepBottomProvider>(context, listen: false);
    final fabProvider = Provider.of<FABProvider>(context, listen: false);

    final selection = providerSelection.getSelection;

    if (selection) {
      providerSelection.setSelection = false;
      providerDeepBottom.setSelection = false;
      fabProvider.setScroll = false;
      providerSelection.getSelected.clear();
      return false;
    } else
      return true;
  }
}

class NoteFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Selector3<NoteDrawerProvider,
          SelectionProvider,
          FABProvider,
          bool>(
          selector: (context, drawerProvider, selectionProvider, fabProvider) =>
          (drawerProvider.getIndexDrawerItem != 1
              ? fabProvider.getScroll
              : true),
          builder: (context, isVisible, widget) {
            return AnimatedAlign(
              alignment:
              isVisible ? Alignment(1.0, 2.0) : Alignment.bottomRight,
              duration: Duration(milliseconds: 350),
              curve: isVisible ? Curves.easeIn : Curves.easeOut,
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xff292929),
                splashColor: Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.16),
                icon: Icon(
                  MyIcon.edit_outline,
                  color: Theme
                      .of(context)
                      .accentColor,
                ),
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Write a note",
                    style: Theme
                        .of(context)
                        .textTheme
                        .button
                        .copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.80)),
                  ),
                ),
                onPressed: () {
                  final drawerProvider =
                  Provider.of<NoteDrawerProvider>(context, listen: false);

                  final FolderNoteData folder = drawerProvider.getFolder;
                  Navigator.pushNamed(context, '/NoteCreate',
                      arguments: folder);
                },
              ),
            );
          }),
    );
  }
}
