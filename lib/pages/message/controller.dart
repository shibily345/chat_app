import 'package:get/get.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/pages/message/state.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();
  void goProfile() async {
    await Get.toNamed(AppRouts.Profile);
  }

  void goContact() async {
    await Get.toNamed(AppRouts.Contact);
  }
}
