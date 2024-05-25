import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});
  Widget _buildPageTitle(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.4,
          ),
          SizedBox(
            height: 90,
            child: SvgPicture.asset(
              'assets/HAYlogo.svg',
            ),
          ),
          const SizedBox(
            height: 280,
          ),
          textWidget(text: "From"),
          SizedBox(
            height: 30,
            child: SvgPicture.asset(
              'assets/C-logo.svg',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        child: _buildPageTitle(controller.title),
      ),
    );
  }
}
