import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/entities/user.dart';

import '../../common/entities/msg.dart';

class MessageState {
  var head_detail = UserItem().obs;
  var my_token = "".obs;
  var my_name = "".obs;
  var my_avatar = "".obs;
  var my_online = "".obs;
  RxList<QueryDocumentSnapshot<Msg>> msgList =
      <QueryDocumentSnapshot<Msg>>[].obs;
  RxList<Msg> msgListR = <Msg>[].obs;
}
