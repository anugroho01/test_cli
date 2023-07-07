import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchpageController extends GetxController {
  //TODO: Implement SearchpageController
  late TextEditingController searchC;

  var awalan = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void cariOrang(String data, String email) async {
    //print("Cari $data");

    if (data.length == 0) {
      awalan.value = [];
      tempSearch.value = [];
    } else {
      var kapital = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(kapital);

      if (awalan.length == 0 && data.length == 1) {
        //jalan saat ketik huruf pertama
        CollectionReference karyawan = await firestore.collection("users");
        final KarResult = await karyawan
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .where("email", isNotEqualTo: email)
            .get();

        print(KarResult.docs.length);

        if (KarResult.docs.length > 0) {
          for (var i = 0; i < KarResult.docs.length; i++) {
            awalan.add(KarResult.docs[i].data() as Map<String, dynamic>);
          }
          print("result");
          print(awalan);
        } else {
          print("no data");
        }
      }

      if (awalan.length != 0) {
        tempSearch.value = [];
        awalan.forEach((element) {
          if (element["name"].startsWith(kapital)) {
            tempSearch.add(element);
          }
        });
      }
    }
    awalan.refresh();
    tempSearch.refresh();
  }

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
