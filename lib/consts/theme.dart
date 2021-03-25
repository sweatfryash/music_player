import 'dart:ui';

import 'package:flutter/material.dart';

final Color white70 = Colors.white.withOpacity(0.7);
final Color white90 = Colors.white.withOpacity(0.9);
final Color white = Colors.white;
final Color white50 = Colors.white.withOpacity(0.5);
final Color white30 = Colors.white.withOpacity(0.3);

final ThemeData myTheme = ThemeData(
  primarySwatch: MaterialColor(0xFFFAFAFA, <int, Color>{
    50: Color(0xFFFEFEFE),
    100: Color(0xFFFEFEFE),
    200: Color(0xFFFDFDFD),
    300: Color(0xFFFCFCFC),
    400: Color(0xFFFBFBFB),
    500: Color(0xFFFAFAFA),
    600: Color(0xFFF9F9F9),
    700: Color(0xFFF9F9F9),
    800: Color(0xFFF8F8F8),
    900: Color(0xFFF6F6F6),
  }),
  //整体为亮色主题
  brightness: Brightness.light,
  //主色
  primaryColor: Color(0xFFFAFAFA),
  accentColor: Color(0xff22d59c),
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xfffafafa),
  bottomAppBarColor: Color(0xffffffff),
  scaffoldBackgroundColor: Color(0xFFFAFAFA),
  //分割线
  dividerColor: Color(0xffdadada),
  highlightColor: Color(0x66bcbcbc),
  splashColor: Color(0x66c8c8c8),
  unselectedWidgetColor: Color(0xfff3f3f3),
  disabledColor: Color(0x61000000),
  toggleableActiveColor: Color(0xff0065cc),
  secondaryHeaderColor: Color(0xffe5f2ff),
  textSelectionColor: Color(0xff99cbff),
  cursorColor: Color(0xff4285f4),
  backgroundColor: Color(0xff99cbff),
  dialogBackgroundColor: Color(0xffffffff),
  indicatorColor: Color(0xff007eff),
  hintColor: Color(0x8a000000),
  errorColor: Color(0xffd32f2f),
);