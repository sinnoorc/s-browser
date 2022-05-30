import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static showSnackBar(String title, String msg, IconData? icon, {Color? color, Duration? duration}) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      title,
      msg,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color ?? Colors.green,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
