import 'package:get/get.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
  }
}
