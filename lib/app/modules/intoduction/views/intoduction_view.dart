import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:ChatApp/app/routes/app_pages.dart';

import '../controllers/intoduction_controller.dart';

class IntoductionView extends GetView<IntoductionController> {
  const IntoductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Berinteraksi dengan mudah",
          body:
              "Kamu hanya perlu akun google dan berkomunikasi dengan teman Kamu",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/main-laptop-duduk.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Temukan Teman baru dan teman lama",
          body:
              "Kamu dapat bernostalgia dengan teman lama maupun mencari teman baru",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/ojek.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Gratis",
          body: "Kamu tidak perlu biaya apapun ",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/payment.json"),
            ),
          ),
        )
      ],
      showSkipButton: true,
      skip: Text("Skip"),
      next: Text("Next"),
      done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w700)),
      onDone: () => Get.offAllNamed(Routes.LOGIN),
      //onSkip: () {},
    ));
  }
}
