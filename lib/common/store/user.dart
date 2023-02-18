import 'dart:convert';

import 'package:get/get.dart';
import 'package:hay_chat/common/entities/user.dart';
import 'package:hay_chat/common/routes/names.dart';
import '../values/storage.dart';
import 'storage.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();
  final _isLogin = false.obs;
  String token = '';
  final _profile = UserItem().obs;
  bool get isLogin => _isLogin.value;
  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;
  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var proffileOffline = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    if (proffileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserItem.fromJson(jsonDecode(proffileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  Future<void> saveProfile(UserItem profile) async {
    _isLogin.value = true;

    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.access_token!);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRouts.Sign_In);
  }
}
