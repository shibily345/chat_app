// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/routes/routes.dart';
import 'package:hay_chat/pages/message/chat/widget/chat_list.dart';
import 'package:iconsax/iconsax.dart';

import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/values/colors.dart';
import 'package:hay_chat/common/widgets/image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/widgets.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: Obx(
        () => SafeArea(
          child: Stack(children: [
            ChatList(),
            Positioned(
              bottom: 20,
              left: 25,
              child: SizedBox(
                width: Get.width,
                // color: blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                        duration: Duration(
                            milliseconds:
                                300), // Adjust animation duration as needed
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: gray),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        width: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: Get.width * 0.58,
                              child: TextFormField(
                                // autofocus: true,
                                //  focusNode: serchFocus,
                                controller: controller.textController,
                                style: TextStyle(
                                    color: Theme.of(context).indicatorColor),
                                // controller: nameController,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .indicatorColor
                                            .withOpacity(0.2)),
                                    hintText: 'Hai...',
                                    border: InputBorder.none),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                controller.sendMessage();
                              },
                              icon: Icon(Iconsax.send_2),
                            ),
                          ],
                        )),
                    controller.textController.text.isEmpty
                        ? IconButton(
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            onPressed: () {
                              controller.goMore();
                            },
                            icon: Icon(
                              Iconsax.clipboard,
                              size: 35,
                            ))
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            controller.state.more_status.value
                ? Positioned(
                    right: 20,
                    bottom: 70,
                    height: 280,
                    width: 40,
                    child: Column(
                      children: [
                        BuildaddIcons(
                          onPressed: () {
                            controller.imageFromGallery();
                            // Get.back();
                          },
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
                          onPressed: () {
                            controller.goVideoCall();
                          },
                          icon: Iconsax.video,
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Iconsax.arrow_left_1)),
      title: Obx(() {
        return textWidget(
            text: controller.token != controller.state.to_token.value
                ? controller.state.to_name.value
                : controller.state.from_name.value,
            fontSize: 20);
      }),
      actions: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: controller.token != controller.state.to_token.value
                  ? controller.state.to_avatar.value
                  : controller.state.from_avatar.value,
              height: 40,
              width: 40,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider)),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 225, 221, 221),
                highlightColor: const Color.fromARGB(255, 254, 252, 252),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 220, 219, 219),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person),
              ),
            ),
            controller.state.to_online == "0"
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: green,
                            width: 2,
                          )),
                    ),
                  )
                : Container()
          ],
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
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
