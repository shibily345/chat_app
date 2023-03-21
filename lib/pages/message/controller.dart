import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/store.dart';
import 'package:hay_chat/pages/message/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/entities/msg.dart';
import '../../common/entities/msgcontent.dart';

class MessageController extends GetxController {
  MessageController();
  final token = UserStore.to.token;
  final state = MessageState();
  final db = FirebaseFirestore.instance;
  var listner;
  // final token = UserStore.to.token;
  void goProfile() async {
    await Get.toNamed(AppRouts.Profile);
  }

  void onRefresh() {
    asyncLoadAlldata().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError(() {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    asyncLoadAlldata().then((_) {
      refreshController.loadComplete();
    }).catchError(() {
      refreshController.loadFailed();
    });
  }

  final navController = PageController();
  void goContact() async {
    await Get.toNamed(AppRouts.Contact);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  asyncLoadAlldata() async {
    var from_message = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: token)
        .get();
    var to_message = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: token)
        .get();
    state.msgList.clear();
    if (from_message.docs.isNotEmpty) {
      state.msgList.assignAll(from_message.docs);
    }
    if (to_message.docs.isNotEmpty) {
      state.msgList.assignAll(to_message.docs);
    }
  }
}
