import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/note/provider/deep_bottom_provider.dart';
import '../../business_logic/note/provider/fab_provider.dart';
import '../../business_logic/note/provider/note_drawer_provider.dart';
import '../../business_logic/note/provider/selection_provider.dart';
import '../../icons/my_icon.dart';
import '../../utility/deep_route_string.dart';
import '../app_theme.dart';
import 'widgets/app_bar/note_default_app_bar.dart';
import 'widgets/build_body.dart';
import 'widgets/drawer/note_drawer.dart';

class NotePage extends StatelessWidget {
  const NotePage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitSelectionOrExitApp(context);
      },
      child: const Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: NoteDrawer(key: Key('Note Drawer')),
          appBar: NoteDefaultAppBar(),
          floatingActionButton: _NoteFABVisible(
            fab: RepaintBoundary(
              child: _AnimateFABScroll(
                fab: _NoteFAB(),
              ),
            ),
          ),
          body: BuildBody()),
    );
  }

  Future<bool> exitSelectionOrExitApp(BuildContext context) async {
    final providerSelection =
        Provider.of<SelectionProvider>(context, listen: false);
    final providerDeepBottom =
        Provider.of<BottomNavBarProvider>(context, listen: false);
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

class _NoteFABVisible extends StatelessWidget {
  const _NoteFABVisible({@required this.fab});

  final Widget fab;

  @override
  Widget build(BuildContext context) {
    final isVisible =
        context.select((SelectionProvider value) => !value.getSelection);

    return Visibility(visible: isVisible, child: fab);
  }
}

class _AnimateFABScroll extends StatelessWidget {
  const _AnimateFABScroll({@required this.fab});

  final Widget fab;

  @override
  Widget build(BuildContext context) {
    final isTrash = context
        .select((NoteDrawerProvider value) => value.getIndexDrawerItem != 1);

    final isNotVisible = isTrash
        ? context.select((FABProvider value) => value.getScrollDown)
        : true;

    return AnimatedAlign(
      alignment:
          isNotVisible ? const Alignment(1.0, 1.5) : Alignment.bottomRight,
      duration: const Duration(milliseconds: 350),
      curve: isNotVisible ? Curves.easeIn : Curves.easeOut,
      child: IgnorePointer(ignoring: isNotVisible, child: fab),
    );
  }
}

class _NoteFAB extends StatelessWidget {
  const _NoteFAB();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      splashColor: Theme.of(context).accentColor.withOpacity(0.16),
      icon: Icon(
        MyIcon.edit_3,
        color: Theme.of(context).accentColor,
      ),
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          'Write a note',
          style: Theme.of(context).textTheme.button.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                color: themeColorOpacity(context: context, opacity: .8),
              ),
        ),
      ),
      onPressed: () {
        final drawerProvider =
            Provider.of<NoteDrawerProvider>(context, listen: false);

        final folder = drawerProvider.getFolder;
        Navigator.pushNamed(context, DeepRouteString.noteCreate,
            arguments: folder);
      },
    );
  }
}
