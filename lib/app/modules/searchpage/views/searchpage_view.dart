import 'package:ChatApp/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  SearchpageView({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: const Text('Search'),
              backgroundColor: Colors.red,
              centerTitle: true,
              flexibleSpace: Padding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      onChanged: (value) =>
                          controller.cariOrang(value, authC.user.value.email!),
                      controller: controller.searchC,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          hintText: "Search Friend",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          suffixIcon: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.red,
                            ),
                            onTap: () {},
                          )),
                    ),
                  )),
            ),
            preferredSize: Size.fromHeight(125)),
        body: Obx(
          () => controller.tempSearch.length == 0
              ? Center(
                  child: Container(
                    height: Get.width * 0.8,
                    width: Get.width * 0.8,
                    child: Lottie.asset("assets/lottie/empty.json"),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.tempSearch.length,
                  itemBuilder: (contex, index) => ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        onTap: () => authC.tambahKoneksi(
                            controller.tempSearch[index]["email"]),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: controller.tempSearch[index]["photoUrl"] ==
                                    "noimage"
                                ? Image.asset(
                                    "assets/logo/noimage.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    controller.tempSearch[index]["photoUrl"],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(
                          "${controller.tempSearch[index]["name"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${controller.tempSearch[index]["email"]}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: GestureDetector(
                            onTap: () => authC.tambahKoneksi(
                                controller.tempSearch[index]["email"]),
                            child: Chip(label: Text("Message"))),
                      )),
        ));
  }
}
