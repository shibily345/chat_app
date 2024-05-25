import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/user.dart';

class RoutAuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;
  RoutAuthMiddleware({required this.priority});
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRouts.Sign_In ||
        route == AppRouts.INITIAL) {
      return null;
    } else {
      Future.delayed(
          Duration(seconds: 2),
          () => Get.snackbar("Tips", 'Login expiers, Please Login Again!',
              colorText: black));
      return const RouteSettings(name: AppRouts.Sign_In);
    }
  }
}
