import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static TextStyle darkTitleAppBar(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        .copyWith(fontSize: SizeHelper.getHeadline5);
  }

  static TextStyle darkTitleFolderAppBar(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontWeight: FontWeight.w600, fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkTitleTrashAppBar(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: SizeHelper.getHeadline5);
  }

  static TextStyle darkTitleSelectionAppBar(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: SizeHelper.getHeadline5);
  }

  static TextStyle darkPopupMenuItem(BuildContext context) {
    return TextStyle(
        fontSize: SizeHelper.getBodyText1,
        color: Colors.white.withOpacity(0.87));
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        popupMenuTheme: PopupMenuThemeData(
            color: Color(0xff202020),
            textStyle: TextStyle(color: Colors.white.withOpacity(0.80))),
        bottomSheetTheme: BottomSheetThemeData(
          modalBackgroundColor: Color(0xff202020),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Color(0xff202020),
        ),
        cardColor: Color(0xff202020).withOpacity(0.90),
        highlightColor: Color(0x424242),
        accentColor: Color(0xffffb348),
        //#fdb368
        primaryColor: Color(0xff121212),
        backgroundColor: Color(0xff121212),
        bottomAppBarColor: Color(0xff121212),
        cursorColor: Color(0xffffb348),
        scaffoldBackgroundColor: Color(0xff121212),
        textSelectionColor: Color(0xffffb348).withOpacity(0.30),
        textSelectionHandleColor: Color(0xffffb348),
        canvasColor: Color(0xff181818),
        textTheme: TextTheme(
            headline5: TextStyle(
              fontFamilyFallback: ["Noto Color Emoji"],
              letterSpacing: 1.2,
              color: Colors.white.withOpacity(0.80),
              fontWeight: FontWeight.w500,
            ),
            headline6: TextStyle(
              fontFamilyFallback: ["Noto Color Emoji"],
              wordSpacing: 1.0,
              height: 1.5,
              color: Colors.white.withOpacity(0.80),
            ),
            bodyText1: TextStyle(
              fontFamilyFallback: ["Noto Color Emoji"],
              wordSpacing: 1.0,
              height: 1.5,
              color: Colors.white70,
            ),
            bodyText2: TextStyle(
              fontFamilyFallback: ["Noto Color Emoji"],
              color: Colors.white.withOpacity(0.87),
            ),
            caption: TextStyle(
                fontFamilyFallback: ["Noto Color Emoji"],
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                fontSize: SizeHelper.getFolder)));
  }
}
