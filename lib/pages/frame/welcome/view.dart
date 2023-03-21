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
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/bwbg1.png',
                ))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: SvgPicture.asset(
                  'assets/HAYlogo.svg',
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 45),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildPageTitle(controller.title),
      ),
    );
  }
}
