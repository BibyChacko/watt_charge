import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:watt_charge_tracker/src/core/theme/text_theme.dart';
import '../theme/app_theme.dart';

class DialogHelper {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showDialog({required String title, required Widget content}) {
    Get.dialog(AlertDialog(
      title: Text(
        title,
        style: AppTextTheme.heading5,
      ),
      content: content,
    ));
  }
}
