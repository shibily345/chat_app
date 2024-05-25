import 'package:get/get.dart';
import 'package:hay_chat/pages/message/controller.dart';

import 'controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  //  Get.lazyPut<MessageController>(() => MessageController());
  }
}
