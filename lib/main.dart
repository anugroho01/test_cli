import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_cli/app/controllers/auth_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/error_screen.dart';
import 'app/utils/loading_screen.dart';
import 'app/utils/splash_screen.dart';

// import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //var snapshot;
        if (snapshot.hasError) {
          return ErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // return GetMaterialApp(
          //   title: "Chat Application",
          //   initialRoute: Routes.CHATROOM,
          //   getPages: AppPages.routes,
          // );

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
              return SplashScreen();
            },
          );
        }
        return LoadingScreen();
      },
    );
  }
}
