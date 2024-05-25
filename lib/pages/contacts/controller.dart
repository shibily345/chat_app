import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/apis/apis.dart';
import 'package:hay_chat/common/entities/entities.dart';
import 'package:hay_chat/common/store/store.dart';
import 'package:hay_chat/pages/contacts/state.dart';

class ContactController extends GetxController {
  ContactController();

  final state = ContactState();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;
  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  Future<void> goChat(ContactItem contactItem) async {
    EasyLoading.show();
    print(
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${contactItem.token}");
    var fromMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: contactItem.token)
        .where("to_token", isEqualTo: token)
        .get();

    var toMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contactItem.token)
        .get();
    EasyLoading.dismiss();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      print(
          "~~~~~~~~~~~~~~~~~~~~~~CREATING NEW~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${contactItem.token}");
      var profile = UserStore.to.profile;
      var msgdata = Msg(
        from_token: profile.token,
        to_token: contactItem.token,
        from_name: profile.name,
        to_name: contactItem.name,
        from_avatar: profile.avatar,
        to_avatar: contactItem.avatar,
        from_online: profile.online,
        to_online: contactItem.online,
        // from_msg_num: profile.token,
        // to_msg_num: contactItem.token,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      var docId = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgdata);
      Get.toNamed("/chat", parameters: {
        "doc_id": docId.id,
        "to_token": contactItem.token ?? "",
        "to_name": contactItem.name ?? "",
        "to_avatar": contactItem.avatar ?? "",
        "to_online": contactItem.online.toString(),
      });
      print('.........user saved..........');
    }
    if (fromMessages.docs.isNotEmpty) {
      print(
          "..........send message---------------- ${fromMessages.docs.first.id}");
      Get.toNamed("/chat", parameters: {
        "doc_id": fromMessages.docs.first.id,
        "to_token": contactItem.token ?? "",
        "to_name": contactItem.name ?? "",
        "to_avatar": contactItem.avatar ?? "",
        "to_online": contactItem.online.toString(),
        // "from_name": msg.from_name ?? "",
        // "msg_from": msg.msg_from ?? "",
        // "from_avatar": msg.from_avatar ?? "",
        // "from_online": msg.from_online.toString(),
      });
    } else {
      print(
          "..........recived message---------------- ${toMessages.docs.first.id}");

      Get.toNamed("/chat", parameters: {
        "doc_id": toMessages.docs.first.id,
        "to_token": contactItem.token ?? "",
        "to_name": contactItem.name ?? "",
        "to_avatar": contactItem.avatar ?? "",
        "to_online": contactItem.online.toString(),
      });
    }
  }

  asyncLoadAllData() async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (kDebugMode) {
      print(result.data!);
    }
    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}
