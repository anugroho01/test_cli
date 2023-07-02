import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController {
  //TODO: Implement ChangeProfileController

  late TextEditingController emailC;
  late TextEditingController namaC;
  late TextEditingController statusC;

  @override
  void onInit() {
    emailC = TextEditingController(text: "email@gmail.com");
    namaC = TextEditingController(text: "Nama Dia");
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
