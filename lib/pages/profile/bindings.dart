import 'package:get/get.dart';

import 'controller.dart';

class ProfilePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(() => ProfilePageController());
  }
}
