import 'package:flutter/material.dart';


var theme = ThemeData(
  appBarTheme: AppBarTheme(
      color: Colors.white,
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 30,
      )
  ),
  textTheme: TextTheme(

    // 로딩 - 로고 스타일
    bodyText2: TextStyle(
      color: Colors.white
    ),

    headline1: TextStyle(
      fontSize: 36,
      color: Colors.white

    ),
    headline2: TextStyle(
      fontSize: 30,
      color: Colors.white
    ),
    headline3: TextStyle(
      fontSize: 24,
      color: Colors.white
    ),
    headline4: TextStyle(
      fontSize: 20,
    ),
    headline5: TextStyle(
      fontSize: 18,
      color: Colors.white
    ),
    headline6: TextStyle(
      fontSize: 16,
      color: Colors.white
    ),

  )
);