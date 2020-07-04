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
    return Theme.of(context).textTheme.bodyText1.copyWith(
        fontFamily: "IBM Plex",
        fontWeight: FontWeight.w600,
        fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkTitleTrashAppBar(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontFamily: "IBM Plex", fontSize: SizeHelper.getHeadline5);
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
        accentColor: Colors.orange[400], //#fdb368
        primaryColor: Color(0xff121212),
        backgroundColor: Color(0xff121212),
        bottomAppBarColor: Color(0xff121212),
        cursorColor: Colors.orange[900],
        scaffoldBackgroundColor: Color(0xff121212),
        textSelectionColor: Colors.orange[900],
        textSelectionHandleColor: Colors.orange[900],
        canvasColor: Color(0xff181818),
        textTheme: TextTheme(
            headline5: TextStyle(
              fontFamily: "IBM Plex",
              letterSpacing: 2.0,
              fontFamilyFallback: ["Noto Color Emoji"],
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
              color: Colors.white.withOpacity(0.80),
            ),
            bodyText2: TextStyle(
              fontFamilyFallback: ["Noto Color Emoji"],
              color: Colors.white.withOpacity(0.87),
            ),
            caption: TextStyle(
                fontFamily: "IBM Plex",
                fontFamilyFallback: ["Noto Color Emoji"],
                color: Colors.white70,
                fontSize: SizeHelper.getFolder)));
  }
}
