import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:hay_chat/common/entities/entities.dart';
import 'package:hay_chat/common/routes/names.dart';
import 'package:hay_chat/common/util/security.dart';
import 'package:hay_chat/pages/message/chat/state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'index.dart';
import '../../../common/store/user.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  late String doc_id;
  final textController = TextEditingController();

  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;
  var listener;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print("no Image Selected");
    }
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = getRandomString(15) + extension(_photo!.path);
    try {
      final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      await ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(fileName);
            sendImageMessage(imgUrl);
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
        }
      });
    } catch (e) {
      print("Errror $e");
    }
  }

  void goMore() {
    state.more_status.value = state.more_status.value ? false : true;
  }

  void goVoiceCall() {
    state.more_status.value = false;
    Get.toNamed(AppRouts.VoiceCall, parameters: {
      "to_token": state.to_token.value,
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      "call_role": "anchor",
      "doc_id": doc_id
    });
  }

  void goVideoCall() {
    state.more_status.value = false;
    Get.toNamed(AppRouts.VideoCall, parameters: {
      "to_token": state.to_token.value,
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      "call_role": "anchor"
    });
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    print(data);
    doc_id = data['doc_id']!;

    state.to_token.value = data['to_token'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    state.to_online.value = data['to_online'] ?? "1";
    state.from_name.value = data['from_name'] ?? "";
    state.msg_from.value = data['msg_from'] ?? "";
    state.from_avatar.value = data['from_avatar'] ?? "";
    state.from_online.value = data['from_online'] ?? "1";

    if (token != state.msg_from.value) {
      db.collection("message").doc(doc_id).update({
        "msg_num": 0,
      });
    }

    print("8888888888888********************${state.msgcontentList}");
    print(".........................................${state.to_token.value}.");
  }

  void sendMessage() async {
    String sendContent = textController.text;
    if (sendContent.isEmpty) {
      return;
    }
    print("...............my token..........................$token.");
    print(
        ".............to token............................${state.to_token.value}.");
    final content = Msgcontent(
        token: token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now());
    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now(),
      "msg_from": token,
      "msg_num": 1,
      // "from_token": token,
      // "to_token": "d13e9a55036a330ed956acff6140ef70",
    });
    print("...............................--------------..........$token.");
  }

  @override
  void onReady() {
    super.onReady();

    final messages = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter<Msgcontent>(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (msgcontent, _) => msgcontent.toFirestore(),
        )
        .orderBy("addtime", descending: false);

    state.msgcontentList.clear();

    listener = messages.snapshots().listen((event) {
      final tempMsgList = event.docChanges
          .where((change) => change.type == DocumentChangeType.added)
          .map((change) => change.doc.data()!)
          .toList();

      state.msgcontentList.value.insertAll(
          0, tempMsgList.reversed); // Efficiently insert at the beginning
      state.msgcontentList.refresh();

      print("Updated chat list: ${state.msgcontentList}");
    }, onError: (error) {
      print("Error listening to chat updates: $error");
      // Retry logic or other error handling here
    });
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    textController.dispose();
    super.dispose();
  }

  sendImageMessage(String url) async {
    final content = Msgcontent(
        token: token, content: url, type: "image", addtime: Timestamp.now());
    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db
        .collection("message")
        .doc(doc_id)
        .update({"last_msg": "[image]", "last_time": Timestamp.now()});
  }
}

Future getImgUrl(String name) async {
  final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
  var str = await spaceRef.getDownloadURL();
  return str;
}
