// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/routes/routes.dart';
import 'package:iconsax/iconsax.dart';

import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/values/colors.dart';
import 'package:hay_chat/common/widgets/image.dart';

import '../../../common/widgets.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});
  Widget _buildPageTitle(String title) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/bg.png',
                ))),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 45),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/whitebg.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: Obx(
          () => SafeArea(
            child: Stack(children: [
              Positioned(
                bottom: 20,
                left: 25,
                child: Container(
                  width: Get.width,
                  // color: blue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: gray),
                        ),
                        width: Get.width * 0.75,
                        height: 45,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                  color: Colors.white.withOpacity(0.2),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        width: Get.width * 0.6,
                                        child: const TextField(
                                          decoration: InputDecoration(
                                              hintText: 'Message...',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                          autofocus: false,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Iconsax.send_2),
                                      ),
                                    ],
                                  )),
                            )),
                      ),
                      IconButton(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          onPressed: () {
                            controller.goMore();
                          },
                          icon: Icon(
                            Iconsax.clipboard,
                            size: 35,
                          )),
                    ],
                  ),
                ),
              ),
              controller.state.more_status.value
                  ? Positioned(
                      right: 20,
                      bottom: 70,
                      height: 230,
                      width: 40,
                      child: Column(
                        children: [
                          BuildaddIcons(
                            onPressed: () {},
                            icon: Iconsax.folder_open,
                          ),
                          BuildaddIcons(
                            onPressed: () {},
                            icon: Iconsax.camera,
                          ),
                          BuildaddIcons(
                            onPressed: () {
                              controller.goVoiceCall();
                            },
                            icon: Iconsax.call_add,
                          ),
                          BuildaddIcons(
                            onPressed: () {},
                            icon: Iconsax.musicnote,
                          ),
                        ],
                      ))
                  : Container(),
            ]),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return buildAppar(
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Iconsax.arrow_left_1)), Obx(() {
      return textWidget(text: "${controller.state.to_name}", fontSize: 20);
    }),
        Stack(
          children: [
            CircleAvatar(
              child: CachedNetworkImage(
                imageUrl: controller.state.to_avatar.value,
                imageBuilder: (context, ImageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: ImageProvider,
                ),
                errorWidget: (context, url, error) => Icon(Iconsax.man),
              ),
              radius: 22,
            ),
            controller.state.to_online == "1"
                ? Positioned(
                    bottom: 8,
                    right: 2,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: green,
                          border: Border.all(
                            color: white,
                            width: 2,
                          )),
                    ),
                  )
                : Container()
          ],
        ),
        Colors.white);
  }
}

class BuildaddIcons extends StatelessWidget {
  Function onPressed;
  IconData icon;
  BuildaddIcons({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryBackground,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(1, 1))
              ]),
          child: Icon(icon)),
    );
  }
}
