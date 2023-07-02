import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_cli/app/routes/app_pages.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  var isSkipIntro = false.obs;
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _usergoogle;
  UserCredential? userCredential;
  Future<void> login() async {
    // Get.offAllNamed(Routes.HOME);
    //fungsi login google
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) => _usergoogle = value);

      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        final googleAuth = await _usergoogle!.authentication;

        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);
        isAuth.value = true;
        Get.offAllNamed(Routes.HOME);
        print(_usergoogle);
      }
      ;
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
