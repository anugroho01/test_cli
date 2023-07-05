import 'package:ChatApp/app/controllers/auth_controller.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();
  //const ChangeProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.namaC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        title: const Text('Change Profile'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                authC.changeprofile(
                    controller.namaC.text, controller.statusC.text);
              },
              icon: Icon(Icons.save))
        ],
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
                  child: Obx(
                    () => ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: authC.user.value.photoUrl == "noimage"
                            ? Image.asset("assets/logo/noimage.png",
                                fit: BoxFit.cover)
                            : Image.network(authC.user.value.photoUrl!,
                                fit: BoxFit.cover)),
                  )),
            ),
            TextField(
              controller: controller.emailC,
              readOnly: true,
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                authC.changeprofile(
                    controller.namaC.text, controller.statusC.text);
              },
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
                    onPressed: () {
                      authC.changeprofile(
                          controller.namaC.text, controller.statusC.text);
                    },
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
