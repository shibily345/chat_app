import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/store/user.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../../common/widgets.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: buildAppar(
        IconButton(
          icon: Icon(
            Iconsax.arrow_left_1,
            size: 25,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        textWidget(text: ''),
        IconButton(
          icon: Icon(
            Iconsax.setting,
            size: 25,
          ),
          onPressed: () {},
        ),
        Colors.transparent,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildProfileDetiles(context),
          const SizedBox(
            height: 300,
          ),
          Container(
              child: Center(
                  child: SpButton(context, title: "Logout", onPressed: () {
            Get.defaultDialog(
                title: "Log out?",
                content: Container(),
                onConfirm: controller.goLogout,
                textConfirm: "Yes",
                textCancel: "No");
          })))
        ],
      ),
    );
  }

  Widget _buildProfileDetiles(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(18),
          ),
          height: 150,
          width: 380,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).splashColor,
                      Theme.of(context).scaffoldBackgroundColor
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: controller.state.my_avatar.value,
                    imageBuilder: (context, ImageProvider) => CircleAvatar(
                      radius: 25,
                      backgroundImage: ImageProvider,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Iconsax.personalcard),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: controller.state.my_name.value,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: controller.state.my_description.value,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Iconsax.edit)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
