import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/provider/note/deep_bottom_provider.dart';
import '../../business_logic/provider/note/fab_provider.dart';
import '../../business_logic/provider/note/note_drawer_provider.dart';
import '../../business_logic/provider/note/selection_provider.dart';
import '../../utility/deep_route_string.dart';
import 'widgets/build_body.dart';
import 'widgets/drawer/note_drawer.dart';
import 'widgets/note_default_app_bar.dart';

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
          drawer: const NoteDrawer(),
          drawerEdgeDragWidth: MediaQuery.of(context).size.width,
          appBar: const NoteDefaultAppBar(),
          floatingActionButton: const _NoteFABVisible(
            fab: _AnimateFABScroll(
              fab: _NoteFAB(),
            ),
          ),
          body: const BuildBody()),
    );
  }

  Future<bool> exitSelectionOrExitApp(BuildContext context) async {
    final providerSelection =
        Provider.of<SelectionProvider>(context, listen: false);
    final providerDeepBottom =
        Provider.of<MainNavigationProvider>(context, listen: false);
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
          isNotVisible ? const Alignment(1.5, 1.0) : Alignment.bottomRight,
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
    return FloatingActionButton(
      heroTag: null,
      splashColor: Theme.of(context).accentColor.withOpacity(0.16),
      child: const Icon(
        FluentIcons.add_28_filled,
        color: Colors.white,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
