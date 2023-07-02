import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchpageController extends GetxController {
  //TODO: Implement SearchpageController
  late TextEditingController searchC;

  @override
  void onInit() {
    searchC = TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
