import 'package:ChatApp/app/data/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ChatApp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _usergoogle;
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var user = UserModel(keyName: null).obs;

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await skipIntro().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    //mengubah skipintro =>true
    final box = GetStorage();
    if (box.read("skipIntro") != null || box.read("skipIntro") == true) {
      return true;
    }
    return false;
  }

  Future<bool> autoLogin() async {
    //mengubah isAuth =>true
    try {
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        //isAuth.value = true;
        await _googleSignIn
            .signInSilently()
            .then((value) => _usergoogle = value);
        final googleAuth = await _usergoogle!.authentication;

        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        //input ke database firebase
        CollectionReference users = firestore.collection('users');

        await users.doc(_usergoogle?.email).update({
          "lastSign":
              userCredential?.user?.metadata.lastSignInTime?.toIso8601String(),
          "updateTime": DateTime.now().toIso8601String()
        });
        final currUser = await users.doc(_usergoogle?.email).get();
        final currUserddata = currUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(currUserddata));

        // user(UserModel(
        //   uid: currUserddata["uid"],
        //   name: currUserddata["name"],
        //   keyName: currUserddata["keyName"],
        //   email: currUserddata["email"],
        //   status: currUserddata["status"],
        //   photoUrl: currUserddata["photoUrl"],
        //   createAt: currUserddata["createdAt"],
        //   lastSign: currUserddata["lastSign"],
        //   updateTime: currUserddata["updateTime"],
        // ));
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> login() async {
    // Get.offAllNamed(Routes.HOME);
    //fungsi login google
    try {
      //untuk handle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      //mendapatkan account google
      await _googleSignIn.signIn().then((value) => _usergoogle = value);

      //cek status login user
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final googleAuth = await _usergoogle!.authentication;

        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        //simpan status user bahwa sdh pernah login dan tidak menampilkan intorduction screen
        final box = GetStorage();
        if (box.read("skipIntro") != null) {
          box.remove("skipIntro");
        }
        box.write("skipIntro", true);

        //input ke database firebase
        CollectionReference users = firestore.collection('users');

        ///cek user sdh pernah login apa belum
        final cekuser = await users.doc(_usergoogle!.email).get();
        if (cekuser.data() == null) {
          await users.doc(_usergoogle?.email).set({
            "uid": userCredential?.user?.uid,
            "name": _usergoogle?.displayName,
            "keyName": _usergoogle?.displayName?.substring(0, 1).toUpperCase(),
            "email": _usergoogle?.email,
            "photoUrl": _usergoogle?.photoUrl ?? 'noimage',
            "status": "",
            "createdAt":
                userCredential?.user?.metadata.creationTime?.toIso8601String(),
            "lastSign": userCredential?.user?.metadata.lastSignInTime
                ?.toIso8601String(),
            "updateTime": DateTime.now().toIso8601String(),
            "chats": []
          });
        } else {
          await users.doc(_usergoogle?.email).update({
            "lastSign": userCredential?.user?.metadata.lastSignInTime
                ?.toIso8601String(),
            "updateTime": DateTime.now().toIso8601String()
          });
        }

        final currUser = await users.doc(_usergoogle?.email).get();
        final currUserddata = currUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(currUserddata));

        // user(UserModel(
        //     uid: currUserddata["uid"],
        //     name: currUserddata["name"],
        //     keyName: currUserddata["keyName"],
        //     email: currUserddata["email"],
        //     status: currUserddata["status"],
        //     photoUrl: currUserddata["photoUrl"],
        //     createAt: currUserddata["createdAt"],
        //     lastSign: currUserddata["lastSign"],
        //     updateTime: currUserddata["updateTime"],
        //     chats: currUserddata["chats"]));

        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
        // print(_usergoogle);
      }
      ;
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();

    Get.offAllNamed(Routes.LOGIN);
  }

  void updateStatus(String status) {
    var tanggal = DateTime.now().toIso8601String();
    //input ke database firebase
    CollectionReference users = firestore.collection('users');

    users.doc(_usergoogle?.email).update({
      "lastSign":
          userCredential?.user?.metadata.lastSignInTime?.toIso8601String(),
      "updateTime": tanggal,
      "status": status
    });

    //update model

    user.update((user) {
      user!.status = status;
      user.lastSign =
          userCredential?.user?.metadata.lastSignInTime?.toIso8601String();
      user.updateTime = tanggal;
    });

    //user(UserModel());

    user.refresh();

    Get.defaultDialog(title: "sukses", middleText: "update status berhasil");
  }

  void changeprofile(String name, String status) {
    var tanggal = DateTime.now().toIso8601String();
    //input ke database firebase
    CollectionReference users = firestore.collection('users');

    users.doc(_usergoogle?.email).update({
      "lastSign":
          userCredential?.user?.metadata.lastSignInTime?.toIso8601String(),
      "updateTime": tanggal,
      "name": name,
      "keyName": name.substring(0, 1).toUpperCase(),
      "status": status
    });

    //update model

    user.update((user) {
      user!.name = name;
      user.keyName = name.substring(0, 1).toUpperCase();
      user.status = status;
      user.lastSign =
          userCredential?.user?.metadata.lastSignInTime?.toIso8601String();
      user.updateTime = tanggal;
    });

    //user(UserModel());

    user.refresh();

    Get.defaultDialog(title: "sukses", middleText: "update profile berhasil");
  }

  void tambahKoneksi(String emailTo) async {
    bool stskoneksiBaru = false;
    String tanggal = DateTime.now().toIso8601String();
    var chat_id;
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    final cekUser = await users.doc(_usergoogle!.email).get();
    final cekChat = (cekUser.data() as Map<String, dynamic>)["chats"] as List;

    if (cekChat.length > 0) {
      //sudah pernah chat (semua orang)

      cekChat.forEach((element) {
        //cek sdh pernah chat dengan =>emailTo ?
        if (element["connection"] == emailTo) {
          chat_id = element["chat_id"];
          print(element["connection"]);
        }
      });

      //jika sdh pernah chat =>emailTo
      if (chat_id != null) {
        stskoneksiBaru = false;
      } else {
        stskoneksiBaru = true;
      }
    } else {
      stskoneksiBaru = true;
    }

    if (stskoneksiBaru) {
// belum pernah chat

//cek dulu apakah emailTo pernah DICHAT?
// 1. jika ada
//2.jika belum
      final chatsDoc = await chats.where("connection", whereIn: [
        [emailTo, _usergoogle!.email],
        [_usergoogle!.email, emailTo]
      ]).get();

      if (chatsDoc.docs.length > 0) {
        //sudah pernah chat antar mereka berdua
        final chatIdData = chatsDoc.docs[0].id;
        final chatData = chatsDoc.docs[0].data() as Map<String, dynamic>;

        cekChat.add({
          "connection": emailTo,
          "chat_id": chatIdData,
          "lastTime": chatData["lastTime"]
        });
        await users.doc(_usergoogle!.email).update({
          "chats": [cekChat]
        });
        user.update((user) {
          user!.chats = cekChat as List<ChatUser>;
        });
        chat_id = chatIdData;
        user.refresh();
      } else {
        // jika belum pernah chat
        final newChatDoc = await chats.add({
          "connection": [
            _usergoogle!.email,
            emailTo,
          ],
          "total_chat": 0,
          "total_read": 0,
          "total_unread": 0,
          "chat": [],
          "lastTime": tanggal
        });

        cekChat.add({
          "connection": emailTo,
          "chat_id": newChatDoc.id,
          "lastTime": tanggal
        });

        await users.doc(_usergoogle!.email).update({"chats": cekChat});

        user.update((user) {
          user!.chats = cekChat as List<ChatUser>;
        });
        chat_id = newChatDoc.id;
        user.refresh();
      }

      //Get.toNamed(Routes.CHATROOM);
    }
    print(chat_id);
    Get.toNamed(Routes.CHATROOM, arguments: chat_id);
  }
}
