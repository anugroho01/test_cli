import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ChatApp/app/controllers/auth_controller.dart';
import 'package:ChatApp/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  //const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => authC.logout(),
              icon: Icon(Icons.logout),
              color: Colors.black)
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                AvatarGlow(
                  endRadius: 110,
                  glowColor: Colors.red,
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: 175,
                    height: 175,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: authC.user.value.photoUrl == "noimage"
                            ? Image.asset("assets/logo/noimage.png",
                                fit: BoxFit.cover)
                            : Image.network(authC.user.value.photoUrl!,
                                fit: BoxFit.cover)),
                  ),
                ),
                Obx(
                  () => Text(
                    "${authC.user.value.name}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Obx(
                  () => Text("${authC.user.value.email}",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_STATUS),
                    leading: Icon(Icons.note_alt),
                    title: Text(
                      "Update Status",
                    ),
                    trailing: Icon(Icons.arrow_right_sharp),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: Icon(Icons.person),
                    title: Text(
                      "Change Profile",
                    ),
                    trailing: Icon(Icons.arrow_right_sharp),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.color_lens),
                    title: Text(
                      "Change Theme",
                    ),
                    trailing: Text("Light"),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chat App",
                  style: TextStyle(fontSize: 25),
                ),
                Text("V23.1")
              ],
            ),
          )
        ],
      ),
    );
  }
}
