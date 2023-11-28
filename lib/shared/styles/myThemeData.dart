import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyThemeData {
  static ThemeData lighttheme = ThemeData(
    scaffoldBackgroundColor: mint,
    appBarTheme: AppBarTheme(color: primaryColor),
    textTheme:
    TextTheme(titleLarge: TextStyle(color: primaryColor, fontSize: 20)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: grayColor),
  );

  static ThemeData darktheme = ThemeData();
}
