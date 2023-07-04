import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ChatApp/app/controllers/auth_controller.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
// import 'app/utils/error_screen.dart';
// import 'app/utils/loading_screen.dart';
import 'app/utils/splash_screen.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => GetMaterialApp(
              title: "Chat Application",
              initialRoute: authC.isSkipIntro.isTrue
                  ? authC.isAuth.isTrue
                      ? Routes.HOME
                      : Routes.LOGIN
                  : Routes.INTODUCTION,
              getPages: AppPages.routes,
            ),
          );
        }
        return FutureBuilder(
            future: authC.firstInitialized(),
            builder: (context, snapshot) => SplashScreen());
      },
    );
  }
}
