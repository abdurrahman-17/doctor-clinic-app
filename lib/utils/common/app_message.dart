import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void appShowToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
      );
}

void failureToast(String message) {
  Get.snackbar(
    'Qbeep',
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
void successToast(String message) {
  Get.snackbar(
    'Qbeep',
    message,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}
