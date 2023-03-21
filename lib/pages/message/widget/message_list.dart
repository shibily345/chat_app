import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/pages/message/controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/entities/msg.dart';
import '../../../common/widgets.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({super.key});
  Widget messageListItem(QueryDocumentSnapshot<Msg> item) {
    return Container(
      //color: green,
      child: InkWell(
        onTap: () {
          //controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              ),
            ),
            Container(
              height: 60,
              width: Get.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: textWidget(
                        text: "${item.data().to_name!}",
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        // controller.goChat(item);
                      },
                      icon: Icon(Iconsax.message_2))
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
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
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  var item = controller.state.msgList[index];
                  return messageListItem(item);
                }, childCount: controller.state.msgList.length)),
              )
            ],
          )),
    );
  }
}
