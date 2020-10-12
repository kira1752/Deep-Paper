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
  return Theme.of(context).textTheme.headline6.copyWith(
      color: themeColorOpacity(context: context, opacity: .87),
      fontWeight: FontWeight.w500,
      fontSize: SizeHelper.getHeadline6);
}

TextStyle noteDrawerTitle({@required BuildContext context}) {
  return Theme.of(context).textTheme.headline6.copyWith(
      color: themeColorOpacity(context: context, opacity: .87),
      fontWeight: FontWeight.w500,
      fontSize: SizeHelper.getTitle);
}

TextStyle menuItemStyle({@required BuildContext context}) {
  return TextStyle(
    fontSize: SizeHelper.getBodyText1,
    color: themeColorOpacity(context: context, opacity: .8),
  );
}

ThemeData dark() {
  return ThemeData.dark().copyWith(
      applyElevationOverlayColor: true,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerColor: const Color(0xff545458).withOpacity(.65),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: Color(0xff1c1c1e),
      ),
      popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xff1c1c1e),
          textStyle: TextStyle(color: Colors.white.withOpacity(0.80))),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: Color(0xff1c1c1e),
        backgroundColor: Color(0xff1c1c1e),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff145374),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xff1c1c1e),
      ),
      dialogBackgroundColor: const Color(0xff1c1c1e),
      cardColor: const Color(0xff2c2c2e),
// Color(0xff1d2025), backup color
      highlightColor: const Color(0x424242),
      accentColor: const Color(0xff64a3c4),
//#fdb368
      primaryColor: const Color(0xff000000),
      backgroundColor: const Color(0xff000000),
      bottomAppBarColor: const Color(0xff000000),
      canvasColor: const Color(0xff1c1c1e),
      cursorColor: const Color(0xff64a3c4),
      appBarTheme: const AppBarTheme(color: Color(0xff000000), elevation: 0.0),
      scaffoldBackgroundColor: const Color(0xff000000),
      textSelectionColor: const Color(0xff64a3c4).withOpacity(0.30),
      textSelectionHandleColor: const Color(0xff64a3c4),
      textTheme: TextTheme(
          headline5: const TextStyle(
            fontFamilyFallback: ['Noto Color Emoji'],
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
