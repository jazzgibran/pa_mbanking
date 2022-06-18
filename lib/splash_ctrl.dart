import 'dart:async';

import 'package:get/get.dart';
import 'landingpage.dart';

class SplashscreenController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    Timer(Duration(seconds: 3), () {
      Get.off(LandingPage());
    });
    super.onReady();
  }
}
