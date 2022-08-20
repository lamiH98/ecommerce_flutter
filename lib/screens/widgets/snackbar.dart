import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackBar(String title, String message) {
  Get.snackbar(title, message,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    margin: const EdgeInsets.all(16.0)
  );
}

showSuccessSnackBar(String title, String message) {
  Get.snackbar(title, message,
    backgroundColor: Color(0xFFCFF0E1),
    colorText: Color(0xFF02C20F),
    margin: const EdgeInsets.all(16.0),
    snackPosition: SnackPosition.BOTTOM,
    borderColor: Color(0xFF02C20F),
    borderWidth: 2,
  );
}