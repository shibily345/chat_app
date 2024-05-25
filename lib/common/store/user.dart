import 'dart:convert';

import 'package:get/get.dart';
import 'package:hay_chat/common/apis/apis.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/storage.dart';

import '../entities/user.dart';
import '../values/storage.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  //lo
  final _isLogin = false.obs;
  //  token
  String token = '';
  //  profile
  final _profile = UserItem().obs;

  bool get isLogin => _isLogin.value;
  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    print(profileOffline);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserItem.fromJson(jsonDecode(profileOffline)));
    }
  }

  //  token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  //  profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    var result = await UserAPI.get_profile();
    _profile(result);
    _isLogin.value = true;
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  // 保存 profile
  Future<void> saveProfile(UserItem profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.access_token!);
  }

  //
  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRouts.Sign_In);
  }
}
