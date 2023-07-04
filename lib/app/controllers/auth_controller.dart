import 'package:ChatApp/app/data/models/user_model.dart';
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

  UserModel user = UserModel();

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

        users.doc(_usergoogle?.email).update({
          "lastSign":
              userCredential?.user?.metadata.lastSignInTime?.toIso8601String(),
          "updateTime": DateTime.now().toIso8601String()
        });
        final currUser = await users.doc(_usergoogle?.email).get();
        final currUserddata = currUser.data() as Map<String, dynamic>;

        user = UserModel(
          uid: currUserddata["uid"],
          name: currUserddata["name"],
          email: currUserddata["email"],
          status: currUserddata["status"],
          photoUrl: currUserddata["photoUrl"],
          createAt: currUserddata["createdAt"],
          lastSign: currUserddata["lastSign"],
          updateTime: currUserddata["updateTime"],
        );
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
          users.doc(_usergoogle?.email).set({
            "uid": userCredential?.user?.uid,
            "name": _usergoogle?.displayName,
            "email": _usergoogle?.email,
            "photoUrl": _usergoogle?.photoUrl ?? 'noimage',
            "status": "",
            "createdAt":
                userCredential?.user?.metadata.creationTime?.toIso8601String(),
            "lastSign": userCredential?.user?.metadata.lastSignInTime
                ?.toIso8601String(),
            "updateTime": DateTime.now().toIso8601String()
          });
        } else {
          users.doc(_usergoogle?.email).update({
            "lastSign": userCredential?.user?.metadata.lastSignInTime
                ?.toIso8601String(),
            "updateTime": DateTime.now().toIso8601String()
          });
        }

        final currUser = await users.doc(_usergoogle?.email).get();
        final currUserddata = currUser.data() as Map<String, dynamic>;

        user = UserModel(
          uid: currUserddata["uid"],
          name: currUserddata["name"],
          email: currUserddata["email"],
          status: currUserddata["status"],
          photoUrl: currUserddata["photoUrl"],
          createAt: currUserddata["createdAt"],
          lastSign: currUserddata["lastSign"],
          updateTime: currUserddata["updateTime"],
        );

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
}
