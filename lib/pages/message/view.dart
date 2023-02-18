import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import 'controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                title: _headBar(context),
              )
            ],
          ),
        ],
      ),
    );
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
                      child: controller.state.head_detail.value.avatar == null
                          ? Icon(
                              Icons.person,
                              size: 30,
                            )
                          : textWidget(text: 'hi'),
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
