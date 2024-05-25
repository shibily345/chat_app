import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/apis/apis.dart';
import 'package:hay_chat/common/entities/base.dart';
import 'package:hay_chat/common/entities/contact.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/store/store.dart';
import 'package:hay_chat/pages/message/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/entities/msg.dart';
import '../../common/entities/msgcontent.dart';

class MessageController extends GetxController {
  MessageController();
  final token = UserStore.to.profile.token;
  final state = MessageState();
  final db = FirebaseFirestore.instance;
  var listner;
  // final token = UserStore.to.token;
  void goProfile() async {
    await Get.toNamed(AppRouts.Profile);
  }

  @override
  void onReady() {
    firebaseMessageSetup();
    // asyncLoadRealTimedata();
    super.onReady();
  }

  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("....... my device token is $fcmToken");
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
          BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }

  void onRefresh() {
    listenToMessagesRealTime();
    // asyncLoadRealTimedata();
    asyncLoadAlldata().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError(() {
      refreshController.refreshFailed();
    });
  }

  @override
  void onInit() {
    UserStore.to.getProfile();
    // var data = Get.parameters;
    state.my_token.value = UserStore.to.profile.token ?? "";
    state.my_name.value = UserStore.to.profile.name ?? "";
    state.my_avatar.value = UserStore.to.profile.avatar ?? "";
    // state.my_online.value = UserStore.to.profile.online.toString() ?? '1';
    // asyncLoadAlldata();
    listenToMessagesRealTime();
    // asyncLoadRealTimedata();
    super.onInit();
  }

  Future<void> goChat(Msg msg) async {
    EasyLoading.show();
    print(
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${msg.to_token}");
    var fromMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: msg.to_token)
        .where("to_token", isEqualTo: token)
        .get();

    var toMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("to_token", isEqualTo: msg.to_token)
        .where("from_token", isEqualTo: token)
        .get();
    var otherMessages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("to_token", isEqualTo: token)
        .where("from_token", isEqualTo: msg.from_token)
        .get();
    if (fromMessages.docs.isNotEmpty) {
      print(
          "..........send message---------------- ${fromMessages.docs.first.id}");
      Get.toNamed("/chat", parameters: {
        "doc_id": fromMessages.docs.first.id,
        "to_token": msg.to_token ?? "",
        "to_name": msg.to_name ?? "",
        "to_avatar": msg.to_avatar ?? "",
        "to_online": msg.to_online.toString(),
        "from_name": msg.from_name ?? "",
        "msg_from": msg.msg_from ?? "",
        "from_avatar": msg.from_avatar ?? "",
        "from_online": msg.from_online.toString(),
      });
    } else if (toMessages.docs.isNotEmpty) {
      // print(
      //     "..........recived message---------------- ${toMessages.docs.first.id}");

      Get.toNamed("/chat", parameters: {
        "doc_id": toMessages.docs.first.id,
        "to_token": msg.to_token ?? "",
        "to_name": msg.to_name ?? "",
        "to_avatar": msg.to_avatar ?? "",
        "msg_from": msg.msg_from ?? "",
        "from_name": msg.from_name ?? "",
        "from_avatar": msg.from_avatar ?? "",
        "from_online": msg.from_online.toString(),
        "to_online": msg.to_online.toString(),
      });
    } else if (otherMessages.docs.isNotEmpty) {
      // print(
      //     "..........recived message---------------- ${otherMessages.docs.first.id}");

      Get.toNamed("/chat", parameters: {
        "doc_id": otherMessages.docs.first.id,
        "to_token": msg.to_token ?? "",
        "to_name": msg.to_name ?? "",
        "to_avatar": msg.to_avatar ?? "",
        "to_online": msg.to_online.toString(),
        "from_name": msg.from_name ?? "",
        "msg_from": msg.msg_from ?? "",
        "from_avatar": msg.from_avatar ?? "",
        "from_online": msg.from_online.toString(),
      });
    } else {
      //  Get.showSnackbar(GetSnackBar(title: msg.to_token!));
      print(
          "~~~~~~~~~~~~~~~~~~~~~FAILED~~~~~~~~~~~~~~~~~~~~~~~~~${token}~~~~~~${msg.from_token}");
    }
    EasyLoading.dismiss();
  }

  void onLoading() {
    listenToMessagesRealTime();
    // asyncLoadRealTimedata();
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
    QuerySnapshot<Msg> sendMessage = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        // .where("from_token", isEqualTo: token)
        //  .where("to_token", isEqualTo: token)
        .get();

    // state.msgList.clear();
    // if (sendMessage.docs.isNotEmpty) {
    //   state.msgList.assignAll(sendMessage.docs);
    // }

    // state.msgList.value = state.msgList.where((msg) {
    //   var data = msg.data();
    //   return data.from_token == token || data.to_token == token;
    // }).toList();
    // state.msgList
    //     .sort((a, b) => b.data().last_time!.compareTo(a.data().last_time!));
    // print(
    //     ">.....................................${state.msgList.length}.........${token}..................................................");
  }

  StreamSubscription? _messagesSubscription;

  void listenToMessagesRealTime() {
    final db = FirebaseFirestore.instance;

    // Cancel previous subscription if it exists
    _messagesSubscription?.cancel();

    _messagesSubscription = db
        .collection("message")
        .withConverter<Msg>(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .snapshots()
        .listen((QuerySnapshot<Msg> snapshot) {
      state.msgList.clear();

      // Check if there are documents
      if (snapshot.docs.isNotEmpty) {
        // You might want to filter on the client-side if Firestore logical OR queries are not feasible
        var filtered = snapshot.docs.where((doc) {
          var data = doc.data();
          return data.from_token == token || data.to_token == token;
        }).toList();

        // Sort the messages before assigning them to the state
        filtered
            .sort((a, b) => b.data().last_time!.compareTo(a.data().last_time!));

        // Assign the filtered and sorted list to your state
        state.msgList.assignAll(filtered);
      }

      print("> Loaded ${state.msgList.length} messages for token: $token");
    }, onError: (error) {
      print("Error listening to messages: $error");
    });
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }
}
