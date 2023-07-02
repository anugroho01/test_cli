import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  SearchpageView({Key? key}) : super(key: key);
  final List<Widget> temans = List.generate(
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
        "email${index + 1}@gmal.com",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Chip(label: Text("Message")),
    ),
  );
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
                    controller: controller.searchC,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        hintText: "Search Friend",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
      body: temans.length == 0
          ? Center(
              child: Container(
                height: Get.width * 0.8,
                width: Get.width * 0.8,
                child: Lottie.asset("assets/lottie/empty.json"),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: temans.length,
              itemBuilder: (contrx, index) => temans[index]),
    );
  }
}
