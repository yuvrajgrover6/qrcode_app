import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrGeneratorController extends GetxController {
  TextEditingController qrController = TextEditingController();

  onSubmit() {
    Get.back();
    qrController.clear();
    Get.snackbar(
      'Saved to Gallery Successfully',
      'Check your gallery to see image',
      backgroundColor: Colors.pink,
      colorText: Colors.white,
    );
  }
}
