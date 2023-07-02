import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  const ChangeProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        title: const Text('Change Profile'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            AvatarGlow(
              endRadius: 75,
              glowColor: Colors.red,
              duration: Duration(seconds: 2),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: AssetImage("assets/logo/noimage.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            TextField(
              controller: controller.emailC,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  label: Text("Email"),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.red)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.namaC,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  label: Text("Nama"),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.red)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.statusC,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  label: Text("Status"),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: Colors.red)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("no image"),
                TextButton(onPressed: () {}, child: Text("pilih gambar"))
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Container(
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Update"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15))))
          ],
        ),
      ),
    );
  }
}
