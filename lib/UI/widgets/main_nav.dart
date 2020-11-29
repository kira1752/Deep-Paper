import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/provider/note/deep_bottom_provider.dart';
import '../../business_logic/provider/note/fab_provider.dart';
import '../../utility/size_helper.dart';
import '../../utility/sizeconfig.dart';
import '../style/app_theme.dart';
import 'main_view.dart';

class MainNav extends StatelessWidget {
  const MainNav();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainNavigationProvider>(
          create: (context) => MainNavigationProvider(),
        ),
        ChangeNotifierProvider<FABProvider>(
          create: (context) => FABProvider(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: const MainView(),
        bottomNavigationBar: Selector<MainNavigationProvider, bool>(
          selector: (context, provider) => provider.isSelectionMode,
          builder: (context, selection, bottomNavigation) => RepaintBoundary(
            child: Visibility(
                visible: selection ? false : true, child: bottomNavigation),
          ),
          child: Selector<MainNavigationProvider, int>(
            selector: (context, provider) => provider.getCurrentIndex,
            builder: (context, index, _) => BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: SizeHelper.button,
              unselectedFontSize: SizeHelper.button,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w600),
              selectedItemColor: Theme.of(context).accentColor.withOpacity(.8),
              unselectedItemColor:
                  themeColorOpacity(context: context, opacity: .6),
              currentIndex: index,
              onTap: (index) {
                final deepProvider = context.read<MainNavigationProvider>();
                final fabProvider = context.read<FABProvider>();

                fabProvider.setScrollDown = false;
                deepProvider.setCurrentIndex = index;
                deepProvider.controller.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FluentIcons.note_24_regular),
                  activeIcon: Icon(FluentIcons.note_24_filled),
                  label: 'Note',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FluentIcons.calendar_24_regular),
                  activeIcon: Icon(FluentIcons.calendar_24_filled),
                  label: 'Plan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FluentIcons.money_24_regular),
                  activeIcon: Icon(FluentIcons.money_24_filled),
                  label: 'Finance',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FluentIcons.more_24_regular),
                  activeIcon: Icon(FluentIcons.more_24_filled),
                  label: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
