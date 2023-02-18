import 'package:get/get.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/pages/frame/welcome/state.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = "HowAreYou .";
  final state = WelcomeState();
  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        Duration(seconds: 3), () => Get.offAllNamed(AppRouts.Message));
  }
}
