import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hay_chat/common/entities/user.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/pages/frame/signin/state.dart';

class SignInController {
  SignInController();
  final state = SignInState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<void> handleSignin(String type) async {
    //email,google,fb,apple,phone
    try {
      if (type == "phone number") {
        if (kDebugMode) {
          print('phone num');
        }
      } else if (type == "google") {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          String? displayname = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/person.png";
          LoginRequestEntity loginPanalListRequestEntity = LoginRequestEntity();
          loginPanalListRequestEntity.avatar = photoUrl;
          loginPanalListRequestEntity.name = displayname;
          loginPanalListRequestEntity.email = email;
          loginPanalListRequestEntity.open_id = id;
          loginPanalListRequestEntity.type = 2;
          asyncPostAllData();
        }
      } else {
        if (kDebugMode) {
          print('NOt SURe');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error login  $e");
      }
    }
  }

  asyncPostAllData() {
    Get.offAllNamed(AppRouts.Message);
  }
}
