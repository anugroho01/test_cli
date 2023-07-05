import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final authC = Get.find<AuthController>();
  //const UpdateStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.statusC.text = authC.user.value.status!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        title: const Text('Update Status'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.statusC,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                authC.updateStatus(controller.statusC.text);
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
              height: 45,
            ),
            Container(
                child: ElevatedButton(
                    onPressed: () {
                      authC.updateStatus(controller.statusC.text);
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
