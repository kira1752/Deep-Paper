import 'package:flutter/material.dart';

import '../utility/size_helper.dart';

/// Set theme color [Opacity].
/// It works for [Light] and [Dark] theme.
/// This method will return color according to [ThemeData] with alpha channel.
Color themeColorOpacity(
    {@required BuildContext context, @required double opacity}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return isDark
      ? Colors.white.withOpacity(opacity)
      : Colors.black.withOpacity(opacity);
}

TextStyle appBarStyle({@required BuildContext context}) {
  return Theme.of(context).textTheme.headline5.copyWith(
      color: themeColorOpacity(context: context, opacity: .8),
      fontWeight: FontWeight.w500,
      fontSize: SizeHelper.getTitle);
}

TextStyle folderAppBarStyle({@required BuildContext context}) {
  return Theme.of(context).textTheme.bodyText1.copyWith(
      color: themeColorOpacity(context: context, opacity: .7),
      fontWeight: FontWeight.w500,
      fontSize: SizeHelper.getTitle);
}

TextStyle trashAppBarStyle({@required BuildContext context}) {
  return Theme.of(context).textTheme.bodyText1.copyWith(
      color: themeColorOpacity(context: context, opacity: .7),
      fontWeight: FontWeight.w500,
      fontSize: SizeHelper.getTitle);
}

TextStyle selectionAppBarStyle({@required BuildContext context}) {
  return Theme.of(context).textTheme.bodyText1.copyWith(
      color: themeColorOpacity(context: context, opacity: .7),
      fontSize: SizeHelper.getTitle);
}

TextStyle menuItemStyle({@required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Ubuntu',
    fontSize: SizeHelper.getBodyText1,
    color: themeColorOpacity(context: context, opacity: .87),
  );
}

ThemeData dark() {
  return ThemeData.dark().copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerColor: Colors.white.withOpacity(.10),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: Color(0xff202125),
      ),
      tooltipTheme: const TooltipThemeData(
          decoration: BoxDecoration(
        color: Color(0xff202125),
      )),
      popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xff202125),
          textStyle: TextStyle(color: Colors.white.withOpacity(0.80))),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: Color(0xff202125),
        backgroundColor: Color(0xff202125),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff26272b),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xff202125),
      ),
      dialogBackgroundColor: const Color(0xff202125),
      cardColor: const Color(0xff1d1d1f),
// Color(0xff1d2025), backup color
      highlightColor: const Color(0x424242),
      accentColor: const Color(0xffffb348),
//#fdb368
      primaryColor: const Color(0xff101115),
      backgroundColor: const Color(0xff101115),
      bottomAppBarColor: const Color(0xff101115),
      cursorColor: const Color(0xffffb348),
      scaffoldBackgroundColor: const Color(0xff101115),
      textSelectionColor: const Color(0xffffb348).withOpacity(0.30),
      textSelectionHandleColor: const Color(0xffffb348),
      canvasColor: const Color(0xff17181c),
      textTheme: TextTheme(
          headline5: const TextStyle(
            fontFamilyFallback: ['Noto Color Emoji'],
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
          headline6: const TextStyle(
            fontFamilyFallback: ['Noto Color Emoji'],
            wordSpacing: 1.0,
          ),
          bodyText1: const TextStyle(
            fontFamilyFallback: ['Noto Color Emoji'],
          ),
          bodyText2: const TextStyle(
            fontFamilyFallback: ['Noto Color Emoji'],
          ),
          caption: TextStyle(
              fontFamilyFallback: const ['Noto Color Emoji'],
              fontWeight: FontWeight.w600,
              fontSize: SizeHelper.getFolder)));
}
