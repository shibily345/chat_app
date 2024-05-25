import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hay_chat/pages/message/chat/controller.dart';
import 'package:intl/intl.dart';

import 'chat_Left_item.dart';
//import 'chat_right_item.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 243, 245),
            Color.fromARGB(255, 225, 225, 226),
            Color.fromARGB(255, 192, 191, 192),
          ], transform: GradientRotation(80)),
        ),
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
              //final item = controller.state.msgcontentList[index];
              final isSentByCurrentUser = controller.token == item.token;
              print(
                  "${controller.token}====================================================");
              print(
                  "${item.token}====================================================");
              var dt = DateTime.fromMillisecondsSinceEpoch(
                  item.addtime!.millisecondsSinceEpoch);

              var d12 = DateFormat('EEE hh:mm a').format(dt);
              return Align(
                  alignment: isSentByCurrentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12, bottom: 20),
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 240, minHeight: 50),
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSentByCurrentUser
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : Colors.white,

                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topRight: isSentByCurrentUser
                                    ? Radius.circular(0)
                                    : Radius.circular(15),
                                topLeft: isSentByCurrentUser
                                    ? Radius.circular(15)
                                    : Radius.circular(0),
                              ), //border: Border.all()
                            ),
                            child: Column(
                              crossAxisAlignment: controller.token == item.token
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                item.type == "text"
                                    ? Text(
                                        "${item.content}",
                                        style: TextStyle(
                                            color: isSentByCurrentUser
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    : ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minWidth: 240, minHeight: 200),
                                        child: GestureDetector(
                                            child: CachedNetworkImage(
                                          imageUrl: "${item.content}",
                                          height: 200,
                                        )),
                                      ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${d12}",
                                  style: TextStyle(
                                      color: isSentByCurrentUser
                                          ? Colors.white.withOpacity(0.4)
                                          : Colors.black.withOpacity(0.4),
                                      fontSize: 10),
                                )
                              ],
                            ))),
                  ));
            }, childCount: controller.state.msgcontentList.length))
          ],
        ),
      ),
    );
  }
}
