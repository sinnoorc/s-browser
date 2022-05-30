import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiException implements Exception {
  static final ApiException instance = ApiException._internal();

  factory ApiException() {
    return instance;
  }

  ApiException._internal();

  static fetchApiException(e) {
    Get.log('\x1B[31m$e\x1B[0m', isError: true);
    if (e is SocketException) {
      return _showDialog('Oops! 😴', 'No internet connection');
    } else if (e is TimeoutException) {
      return _showSnackBar('Oops! 😔', 'Unable to connect to server');
    } else if (e is HttpException) {
      return _showSnackBar('Oops! 😔', 'Unable to connect to server');
    } else if (e is FormatException) {
      return _showSnackBar('Oops!', 'Something went wrong please try again...');
    } else {
      return _showSnackBar('Oops!', 'Something went wrong please try again...');
    }
  }

  static const Duration connectionTimeOut = Duration(seconds: 30);

  static _showSnackBar(String title, String msg, {IconData? icon}) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      title,
      msg,
      icon: Icon(icon ?? Icons.error, color: Colors.white),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  static _showDialog(String title, String msg) {
    if (Get.isDialogOpen!) Get.back();
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
