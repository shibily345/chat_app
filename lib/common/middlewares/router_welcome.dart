import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hay_chat/common/routes/names.dart';

import '../store/config.dart';
import '../store/user.dart';

///
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    print(ConfigStore.to.isFirstOpen);
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return RouteSettings(name: AppRouts.Message);
    } else {
      return RouteSettings(name: AppRouts.Sign_In);
    }
  }
}
