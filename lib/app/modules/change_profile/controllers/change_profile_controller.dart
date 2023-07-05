import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  //TODO: Implement ChangeProfileController

  late TextEditingController emailC;
  late TextEditingController namaC;
  late TextEditingController statusC;

  @override
  void onInit() {
    emailC = TextEditingController();
    namaC = TextEditingController();
    statusC = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailC.dispose();
    namaC.dispose();
    statusC.dispose();
    super.onClose();
  }
}
