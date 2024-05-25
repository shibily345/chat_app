import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/pages/message/controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/entities/msg.dart';
import '../../../common/widgets.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});
  Widget messageListItem(
      QueryDocumentSnapshot<Msg> item, BuildContext context) {
    var dt = DateTime.fromMillisecondsSinceEpoch(
        item.data().last_time!.millisecondsSinceEpoch);

    var d12 = DateFormat('E hh:mm a').format(dt);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              //  color: green,

              onTap: () {
                controller.goChat(item.data());
              },
              leading: Container(
                height: 40,
                width: 40,
                child: CachedNetworkImage(
                  imageUrl: item.data().from_token == controller.token
                      ? item.data().to_avatar!
                      : item.data().from_avatar!,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider)),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.black),
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
              ),

              title: textWidget(
                  text: item.data().from_token == controller.token
                      ? item.data().to_name!
                      : item.data().from_name!,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
              subtitle: textWidget(
                  text: item.data().msg_from == controller.token
                      ? "⇗ ${item.data().last_msg!}"
                      : "⇙ ${item.data().last_msg!}",
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  textWidget(
                      text: "$d12", fontWeight: FontWeight.w300, fontSize: 10),
                  SizedBox(
                    height: 8,
                  ),
                  if (item.data().msg_num != 0)
                    CircleAvatar(
                        radius: 5,
                        backgroundColor:
                            controller.token != item.data().msg_from
                                ? green.withOpacity(.8)
                                : Colors.grey.withOpacity(.8))
                  else
                    SizedBox()
                ],
              ),
            ),
          ),
          Divider(height: .6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onLoading: controller.onLoading,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: controller.state.msgList.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var item = controller.state.msgList[index];
                            // Check if the current message is equal to "requested"
                            if (item.data().last_msg != "") {
                              // Return a regular message item
                              return messageListItem(item, context);
                            }
                          },
                          // Add 1 to include the "Requested" section
                          childCount: controller.state.msgList.length,
                        ),
                      ),
                    )
                  ],
                )
              : Center(child: Text('Welcome to Hey Chat '))),
    );
  }
}
