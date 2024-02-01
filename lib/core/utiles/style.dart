import 'package:flutter/material.dart';

abstract final class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      backgroundColor: isDarkTheme ? Colors.white38 : Colors.white60,
      primaryColor: isDarkTheme ? const Color.fromRGBO(22, 105, 122, 1.0) : const Color(0xffccd5ae),
      secondaryHeaderColor: isDarkTheme ? const Color.fromRGBO(28, 112, 168, 1.0) : const Color(0xfffaedcd),
      hintColor: isDarkTheme ? Colors.white38 : Colors.black54,
      highlightColor: isDarkTheme ? const Color(0xff372901) :
      const Color(0xfffefae0),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B)
          :const Color(0xfffefae0),
      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xfffaedcd),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Colors.grey.shade400 : const Color(0xFFfaedcd),
      iconTheme: IconThemeData(color: isDarkTheme ? Colors.white60 : Colors.black54),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
          ),
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? const Color.fromRGBO(22, 105, 122, 1.0) : const Color(0xffccd5ae),
        elevation: 0.5,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: isDarkTheme ? Colors.cyan : Colors.lime).copyWith(
        background: isDarkTheme ? Colors.black : const Color(0xffccd5ae),
        primary: isDarkTheme ? const Color.fromRGBO(22, 105, 122, 1.0) : const Color(0xffccd5ae),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
      ),
    );
  }
}
