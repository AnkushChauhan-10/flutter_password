import 'package:flutter/material.dart';

abstract final class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
        background: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
      ),
    );
  }
}
