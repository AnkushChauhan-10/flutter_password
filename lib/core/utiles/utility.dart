import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Utility {
  Utility._();

  /// Getx Snack Bar -> Toast message
  static void toastMessage({
    required String title,
    required String message,
    Icon? icon,
  }) =>
      Get.showSnackbar(
        GetSnackBar(
          title: title,
          message: message,
          icon: icon,
          duration: const Duration(seconds: 2),
        ),
      );

  /// Getx Snack Bar -> Screen Loader dialog
  static void loaderScreen() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
