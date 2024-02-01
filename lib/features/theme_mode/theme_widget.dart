import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password/features/theme_mode/theme_controller.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModeController>(
      builder: (ctrl) {
        return IconButton(
          onPressed: () {
            ctrl.darkTheme = ctrl.darkTheme ? false : true;
          },
          icon: Icon(
            !ctrl.darkTheme ? Icons.dark_mode : Icons.sunny,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
