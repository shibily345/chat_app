import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hay_chat/common/apis/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/entities/user.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/user.dart';
import 'package:hay_chat/pages/frame/signin/state.dart';
import '../../../common/widgets/toast.dart';

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
          print(jsonEncode(loginPanalListRequestEntity));
          asyncPostAllData(loginPanalListRequestEntity);
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

  asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    // var respones = await HttpUtil().get('/api/index');
    // print(respones);

    EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: white,
        ),
        maskType: EasyLoadingMaskType.none,
        dismissOnTap: true);
    var result = await UserAPI.Login(params: loginRequestEntity);
    print(result.data);
    if (result.code == 1) {
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();

      toastInfo(msg: "internet error");
    }

    Get.offAllNamed(AppRouts.Message);
  }
}
