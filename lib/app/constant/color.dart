import 'package:flutter/material.dart';

const appNormalPurple = Color(0XFF431AA1);
const appWhite = Color(0XFFFAF8FC);
const appDarkPurple = Color(0XFF2E0D8A);
const appLightPurple = Color(0XFF9345F2);
const appGrey = Color(0XFFB9A2D8);
const appOrange = Color(0XFFE6704A);

ThemeData themeLight = ThemeData(
    primaryColor: appNormalPurple,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: appNormalPurple));

ThemeData themeDark = ThemeData(
    primaryColor: appLightPurple,
    scaffoldBackgroundColor: appDarkPurple,
    appBarTheme: AppBarTheme(backgroundColor: appNormalPurple),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)));
