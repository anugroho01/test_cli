import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();

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
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.chatStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var allChats = (snapshot1.data!.data()
                      as Map<String, dynamic>)["chats"] as List;
                  print(allChats.length);

                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allChats.length,
                      itemBuilder: (contex, index) {
                        return StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller
                                .friendStream(allChats[index]["connection"]),
                            builder: (contex, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.active) {
                                var dataorg = snapshot2.data!.data();
                                return dataorg!["status"] == ""
                                    ? ListTile(
                                        onTap: () =>
                                            Get.toNamed(Routes.CHATROOM),
                                        leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: dataorg!["photoUrl"] ==
                                                      'noimage'
                                                  ? Image.asset(
                                                      "assets/logo/noimage.png",
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      "${dataorg["photoUrl"]}",
                                                      fit: BoxFit.cover,
                                                    ),
                                            )),
                                        title: Text(
                                          " ${dataorg["name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: allChats[index]
                                                    ["total_unread"] ==
                                                0
                                            ? SizedBox()
                                            : Chip(
                                                label: Text(
                                                    "${allChats[index]["total_unread"]}")),
                                      )
                                    : ListTile(
                                        onTap: () =>
                                            Get.toNamed(Routes.CHATROOM),
                                        leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: dataorg!["photoUrl"] ==
                                                      'noimage'
                                                  ? Image.asset(
                                                      "assets/logo/noimage.png",
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      "${dataorg["photoUrl"]}",
                                                      fit: BoxFit.cover,
                                                    ),
                                            )),
                                        title: Text(
                                          " ${dataorg["name"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "${dataorg["status"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: allChats[index]
                                                    ["total_unread"] ==
                                                0
                                            ? SizedBox()
                                            : Chip(
                                                label: Text(
                                                    "${allChats[index]["total_unread"]}")),
                                      );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            // child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     itemCount: 11,
            //     itemBuilder: (contx, index) => myChats[index])
          )
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
