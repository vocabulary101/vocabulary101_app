import 'package:flutter/material.dart';
import 'package:vocabulary101_app/app/core/themes/text_theme.dart';

class LightTheme {
  static const _primaryColor = Color(0xFF8462C1);
  // static const _primaryColor = Colors.blueAccent;

  static ThemeData data = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.compact,
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    primaryColor: _primaryColor,
    fontFamily: 'Montserrat',
    textTheme: textTheme.copyWith(
        // headline2: textTheme.headline2!.copyWith(
        //   color: Colors.black,
        // ),
        // headline4: textTheme.headline4!.copyWith(
        //   color: Colors.black,
        // ),
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xff555555),
      ),
    ),
    // tabBarTheme: const TabBarTheme(
    //   labelColor: Colors.black,
    //   unselectedLabelColor: Colors.black87,
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black87,
      selectedItemColor: _primaryColor,
      backgroundColor: Colors.white,
      elevation: 0,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    // dividerColor: Colors.black12,
    // tooltipTheme: TooltipThemeData(
    //   padding: const EdgeInsets.all(12),
    //   decoration: BoxDecoration(
    //     color: Colors.black.withOpacity(.9),
    //     borderRadius: BorderRadius.circular(4),
    //   ),
    //   textStyle: const TextStyle(fontSize: 14, height: 1, color: Colors.white),
    // ),
    // snackBarTheme: SnackBarThemeData(
    //   backgroundColor: Colors.black.withOpacity(.85),
    //   actionTextColor: Colors.white,
    // ),
  );
}
