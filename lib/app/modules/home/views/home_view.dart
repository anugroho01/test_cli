import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final List<Widget> myChats = List.generate(
    11,
    (index) => ListTile(
      onTap: () => Get.toNamed(Routes.CHATROOM),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey,
        child: Image.asset(
          "assets/logo/noimage.png",
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        "nama ke ${index + 1}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "status ke ${index + 1}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Chip(label: Text("1")),
    ),
  ).reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chats",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person_2,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 11,
                  itemBuilder: (contrx, index) => myChats[index]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCHPAGE),
        child: Icon(Icons.search),
        backgroundColor: Colors.red,
      ),
    );
  }
}
