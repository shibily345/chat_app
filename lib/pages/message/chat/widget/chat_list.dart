import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hay_chat/pages/message/chat/controller.dart';

import 'chat_Left_item.dart';
import 'chat_right_item.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [
            //   Color.fromARGB(255, 158, 49, 242),
            //   Color.fromARGB(255, 93, 29, 230),
            //   Color.fromARGB(255, 144, 131, 226),
            //   Color.fromARGB(255, 62, 7, 243),
            // ], transform: GradientRotation(90)),
            image: DecorationImage(
                image: AssetImage("assets/whitebg.jpg"), fit: BoxFit.cover)),
        padding: EdgeInsets.only(bottom: 70),
        child: CustomScrollView(
          reverse: true,
          controller: controller.msgScrolling,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              var item = controller.state.msgcontentList[index];
              if (controller.user_id == item.token) {
                return chatRightItem(item);
              }
              return chatleftItem(item);
            }, childCount: controller.state.msgcontentList.length))
          ],
        ),
      ),
    );
  }
}
