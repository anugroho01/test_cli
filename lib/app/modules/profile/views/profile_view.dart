import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.logout), color: Colors.black)
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: AssetImage("assets/logo/noimage.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Text(
                  "Nama",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text("email@gmail.com",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center),
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
                    leading: Icon(Icons.note_alt),
                    title: Text(
                      "Update Status",
                    ),
                    trailing: Icon(Icons.arrow_right_sharp),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Change Profile",
                    ),
                    trailing: Icon(Icons.arrow_right_sharp),
                  ),
                  ListTile(
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