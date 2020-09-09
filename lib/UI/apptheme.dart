import 'package:deep_paper/utility/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  AppTheme._();

  static TextStyle darkTitleAppBar() {
    return Get.textTheme.headline5.copyWith(fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkTitleFolderAppBar() {
    return Get.textTheme.bodyText1
        .copyWith(fontWeight: FontWeight.w600, fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkTitleTrashAppBar() {
    return Get.textTheme.bodyText1
        .copyWith(fontWeight: FontWeight.w600, fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkTitleSelectionAppBar() {
    return Get.textTheme.bodyText1.copyWith(fontSize: SizeHelper.getTitle);
  }

  static TextStyle darkPopupMenuItem() {
    return TextStyle(
        fontSize: SizeHelper.getBodyText1,
        color: Colors.white.withOpacity(0.87));
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: Colors.white.withOpacity(.10),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Color(0xff202125),
        ),
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
            headline5: TextStyle(
              fontFamilyFallback: ['Noto Color Emoji'],
              letterSpacing: 1.2,
              color: Colors.white.withOpacity(0.80),
              fontWeight: FontWeight.w600,
            ),
            headline6: TextStyle(
              fontFamilyFallback: ['Noto Color Emoji'],
              wordSpacing: 1.0,
              color: Colors.white.withOpacity(0.80),
            ),
            bodyText1: const TextStyle(
              fontFamilyFallback: ['Noto Color Emoji'],
              color: Colors.white70,
            ),
            bodyText2: const TextStyle(
              fontFamilyFallback: ['Noto Color Emoji'],
              color: Colors.white54,
            ),
            caption: TextStyle(
                fontFamilyFallback: ['Noto Color Emoji'],
                color: Colors.white.withOpacity(.80),
                fontWeight: FontWeight.w600,
                fontSize: SizeHelper.getFolder)));
  }
}
