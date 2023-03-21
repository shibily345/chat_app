import 'package:get/get.dart';
import 'package:hay_chat/pages/contacts/controller.dart';

import 'controller.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
