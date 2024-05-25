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
        backgroundColor: Theme.of(context).splashColor,
        // bottomNavigationBar: NavBar(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.goContact();
          },
          child: Icon(Iconsax.message_add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _appBar(context),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: MessageList()),
              )
            ],
          ),
        ));
  }

  Widget _appBar(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              height: 55,
              width: 55,
              child: CachedNetworkImage(
                imageUrl: controller.state.my_avatar.value,
                imageBuilder: (context, ImageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: ImageProvider,
                ),
                errorWidget: (context, url, error) =>
                    Icon(Iconsax.personalcard),
              ),
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: textWidget(
                text: "Messages", fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.only(left: 120),
              child: IconButton(
                  onPressed: () {
                    controller.goProfile();
                  },
                  icon: Icon(Iconsax.setting))),
        ],
      ),
    );
  }
}
