import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';
import '../../common/widgets.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/bg1.png',
                ))),
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                  Spacer(),
                  Icon(
                    Icons.settings,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: BlurContainer(
                  context,
                  200,
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 115,
                          width: 115,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [sgreen, blue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            shape: BoxShape.circle,
                          ),
                          child:
                              controller.state.Profile_pic.value.avatar == null
                                  ? Icon(
                                      Icons.person,
                                      size: 90,
                                    )
                                  : textWidget(text: 'hi'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            child: CircleAvatar(
                              radius: 18,
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            BlurContainer(
                context,
                300,
                CustomScrollView(
                  slivers: [],
                )),
            SizedBox(
              height: 40,
            ),
            BlurContainer(
                context,
                150,
                Center(
                    child: SpButton(context, title: "Logout", onPressed: () {
                  Get.defaultDialog(
                      title: "Sre you Sure to log out?",
                      content: Container(),
                      onConfirm: controller.goLogout,
                      textConfirm: "Yes",
                      textCancel: "No");
                })))
          ],
        ),
      ),
    );
  }
}
