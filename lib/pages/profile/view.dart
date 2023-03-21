import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../../common/widgets.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 252, 251),
              Color.fromARGB(255, 17, 172, 233),
            ],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
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

  Widget _buildProfileDetiles(BuildContext context) {
    return Center(
      child: BlurContainer(
          context,
          200,
          380,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [sgreen, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                      ),
                      child: controller.state.Profile_pic.value.avatar == null
                          ? const Icon(
                              Icons.person,
                              size: 70,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  controller.state.Profile_pic.value.avatar!,
                              imageBuilder: (context, ImageProvider) =>
                                  CircleAvatar(
                                radius: 25,
                                backgroundImage: ImageProvider,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Iconsax.man),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        child: const CircleAvatar(
                          radius: 18,
                          child: Icon(Iconsax.camera),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: 'Mohamed Shibily',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: 'Modesty Brings Happy ',
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
