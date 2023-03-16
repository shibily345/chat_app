import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:hay_chat/pages/contacts/controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/entities/contact.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              var item = controller.state.contactList[index];
              return _builslistItem(item);
            },
            childCount: controller.state.contactList.length,
          )),
        )
      ]);
    });
  }

  Widget _builslistItem(ContactItem item) {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              controller.goChat(item);
            },
            child: Container(
              height: 40,
              width: 40,
              child: CachedNetworkImage(
                imageUrl: item.avatar!,
                height: 40,
                width: 40,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: imageProvider)),
                ),
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
                      text: "${item.name!}",
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      controller.goChat(item);
                    },
                    icon: Icon(Iconsax.message_2))
              ],
            ),
          )
        ],
      ),
    );
  }
}
