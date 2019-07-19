import 'package:flutter/material.dart';

//色值：d8e2dc/ffe5d9/ffcad4/e592a6/9d8189
ThemeData _themeData = ThemeData(
  primaryColor: Color(0xffe592a6),
  canvasColor: Colors.white,
  disabledColor: Color(0xff9d8189),
  scaffoldBackgroundColor: Color(0xffffcad4),
  textTheme: TextTheme(
    caption: TextStyle(
      color: Colors.black87
    )
  )
);

ThemeData getThemeData() => _themeData;
