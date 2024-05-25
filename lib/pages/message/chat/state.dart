import 'package:get/get.dart';
import 'package:hay_chat/common/entities/entities.dart';

class ChatState {
  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_online = "".obs;
  var from_name = "".obs;
  var from_avatar = "".obs;
  var from_online = "".obs;
  var msg_from = "".obs;
  RxBool more_status = false.obs;
}
