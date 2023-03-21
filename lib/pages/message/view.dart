import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:hay_chat/pages/message/widget/message_list.dart';
import 'package:hay_chat/pages/message/widget/nav_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: NavBar(),
        appBar: _appBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.goContact();
          },
          child: Icon(Iconsax.message_add),
        ),
        body: MessageList());
  }

  AppBar _appBar(BuildContext context) {
    return buildAppar(
        GestureDetector(
            onTap: () {
              controller.goProfile();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                      color: Theme.of(context).splashColor,
                    ),
                  ],
                  gradient: const LinearGradient(
                      colors: [sgreen, blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  shape: BoxShape.circle,
                ),
                child: controller.state.head_detail.value.avatar == null
                    ? Icon(
                        Icons.person,
                        size: 30,
                      )
                    : Image.network(
                        "${controller.state.head_detail.value.avatar}"),
              ),
            )),
        textWidget(text: "HAY Chat", fontSize: 25, fontWeight: FontWeight.bold),
        Icon(Iconsax.setting),
        Colors.transparent);
  }

  Widget _headBar(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        height: 50,
        margin: EdgeInsets.only(
          bottom: 20,
          top: 20,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      controller.goProfile();
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 1),
                            color: Theme.of(context).splashColor,
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: [sgreen, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                      ),
                      child: controller.state.head_detail.value != null
                          ? Icon(
                              Icons.person,
                              size: 30,
                            )
                          : Image.network(
                              "${controller.state.head_detail.value.avatar}"),
                    )),
                Positioned(
                    bottom: 3,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 128, 224, 17),
                      radius: 6,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
