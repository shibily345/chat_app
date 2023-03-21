import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/pages/message/controller.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class NavBar extends GetView<MessageController> {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RollingBottomBar(
      controller: controller.navController,
      items: [
        RollingBottomBarItem(Icons.home, label: 'Home'),
        RollingBottomBarItem(Icons.star, label: 'Chat'),
        RollingBottomBarItem(Icons.person, label: 'Profile'),
        // RollingBottomBarItem(Icons.access_alarm, label: 'Page 4'),
      ],
      activeItemColor: Colors.green.shade700,
      enableIconRotation: true,
      onTap: (index) {
        controller.navController.animateToPage(
          index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      },
    );
  }
}
