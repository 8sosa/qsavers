import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantity_savers/app/core/values/app_strings.dart';

void showCustomSnackbar(String groupName) {
  Get.closeAllSnackbars();
  Get.snackbar(
    strApplicationName,
    '',
    colorText: Colors.black,
    messageText: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Before you may join the campaign,you must first join',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextSpan(
            text: '\"$groupName\"',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
