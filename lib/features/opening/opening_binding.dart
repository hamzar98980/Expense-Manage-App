import 'package:get/get.dart';

import 'opening_controller.dart';

class OpeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OpeningController>(OpeningController());
  }
}
