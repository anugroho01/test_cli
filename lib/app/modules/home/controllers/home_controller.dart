import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final listChat = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void cariTeman(String idChat) async {
    CollectionReference chats = await firestore.collection("chats");
    final chatResult = await chats.where("chat_id", isEqualTo: idChat);

    print(chatResult);
  }
}
