import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/user.dart';
import 'package:hay_chat/pages/profile/state.dart';

class ProfilePageController extends GetxController {
  ProfilePageController();
  final title = "Profile";
  final state = ProfilePageState();
  @override
  void onInit() {
    UserStore.to.getProfile;
    state.my_name.value = UserStore.to.profile.name ?? "";
    state.my_avatar.value = UserStore.to.profile.avatar ?? "";
    state.my_token.value = UserStore.to.profile.token ?? "";
    state.my_description.value = UserStore.to.profile.description ?? "loading...";

    super.onInit();
  }

  void goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
