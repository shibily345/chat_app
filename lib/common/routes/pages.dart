import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hay_chat/common/middlewares/router_auth.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/pages/frame/signin/view.dart';
import 'package:hay_chat/pages/frame/welcome/index.dart';
import 'package:hay_chat/pages/message/index.dart';
import 'package:hay_chat/pages/frame/signin/bindings.dart';

class AppPages {
  static const INITIAL = AppRouts.INITIAL;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];
  static final List<GetPage> routes = [
    GetPage(
      name: AppRouts.INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
        name: AppRouts.Message,
        page: () => MessagePage(),
        binding: MessageBinding(),
        middlewares: [RoutAuthMiddleware(priority: 1)]),
    GetPage(
        name: AppRouts.Sign_In,
        page: () => SignInPage(),
        binding: SignInBinding(),
        middlewares: [RoutAuthMiddleware(priority: 1)])
  ];
}
