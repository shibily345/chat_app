import 'package:get/get.dart';
import 'package:hay_chat/pages/contacts/controller.dart';
import 'package:hay_chat/pages/message/controller.dart';

import 'controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
