import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/user.dart';
import 'package:hay_chat/pages/profile/state.dart';

class ProfilePageController extends GetxController {
  ProfilePageController();
  final title = "Profile";
  final state = ProfilePageState();
  void goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
