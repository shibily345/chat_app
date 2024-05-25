import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:hay_chat/pages/contacts/controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

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
            horizontal: 10,
          ),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              var item = controller.state.contactList[index];
              return _builslistItem(item, context);
            },
            childCount: controller.state.contactList.length,
          )),
        )
      ]);
    });
  }

  Widget _builslistItem(ContactItem item, BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.goChat(item);
        },
        child: ListTile(
          // margin: EdgeInsets.all(5),
          // padding: EdgeInsets.all(8),
          // height: 80,
          // decoration: BoxDecoration(
          //     color: const Color.fromARGB(255, 240, 237, 237),
          //     borderRadius: BorderRadius.circular(20)),
          leading: CachedNetworkImage(
            imageUrl: item.avatar!,
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
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
          title: textWidget(
              text: "${item.name!}",
              fontWeight: FontWeight.normal,
              fontSize: 16),
          subtitle: textWidget(
              text: "${item.description!}",
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Theme.of(context).primaryColor.withOpacity(0.6)),
        ));
  }
}
