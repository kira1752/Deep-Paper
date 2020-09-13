import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../business_logic/note/provider/fab_provider.dart';
import '../../business_logic/note/provider/note_drawer_provider.dart';
import '../../business_logic/note/provider/selection_provider.dart';
import '../../icons/my_icon.dart';
import '../../utility/deep_route_string.dart';
import '../../utility/size_helper.dart';
import 'widgets/app_bar/note_default_app_bar.dart';
import 'widgets/build_body.dart';
import 'widgets/drawer/deep_drawer.dart';

class NotePage extends StatelessWidget {
  const NotePage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitSelectionOrExitApp(context);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const DeepDrawer(key: Key('Note Drawer')),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeHelper.setHeight(size: 56)),
              child: const NoteDefaultAppBar()),
          floatingActionButton: Selector<SelectionProvider, bool>(
            selector: (context, selectionProvider) =>
                !selectionProvider.getSelection,
            builder: (context, selection, fab) =>
                Visibility(visible: selection, child: fab),
            child: const NoteFloatingActionButton(),
          ),
          body: const BuildBody()),
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
      fabProvider.setScrollDown = false;
      providerSelection.getSelected.clear();
      return false;
    } else {
      return true;
    }
  }
}

class NoteFloatingActionButton extends StatelessWidget {
  const NoteFloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child:
      Selector3<NoteDrawerProvider, SelectionProvider, FABProvider, bool>(
        selector: (context, drawerProvider, selectionProvider, fabProvider) =>
        (drawerProvider.getIndexDrawerItem != 1
            ? fabProvider.getScrollDown
            : true),
        builder: (context, isNotVisible, fab) =>
            AnimatedAlign(
              alignment:
              isNotVisible ? const Alignment(1.0, 1.5) : Alignment.bottomRight,
              duration: const Duration(milliseconds: 350),
              curve: isNotVisible ? Curves.easeIn : Curves.easeOut,
              child: IgnorePointer(ignoring: isNotVisible, child: fab),
            ),
        child: FloatingActionButton.extended(
          heroTag: null,
          elevation: 0.0,
          splashColor: Theme
              .of(context)
              .accentColor
              .withOpacity(0.16),
          icon: Icon(
            MyIcon.edit_3,
            color: Theme
                .of(context)
                .accentColor,
          ),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Write a note',
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

            final folder = drawerProvider.getFolder;
            Get.toNamed(DeepRouteString.noteCreate, arguments: folder);
          },
        ),
      ),
    );
  }
}
