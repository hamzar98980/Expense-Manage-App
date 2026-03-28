import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  static const _splashDuration = Duration(seconds: 3);

  @override
  void onReady() {
    super.onReady();
    Future<void>.delayed(_splashDuration, () {
      Get.offNamed(AppRoutes.opening);
    });
  }
}
