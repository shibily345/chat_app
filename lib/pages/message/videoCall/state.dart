import 'package:get/get.dart';

class VideoCallState {
  RxBool isJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableVideo = true.obs;
  RxInt remoteUid = 0.obs;
  RxString calltime = "00.00".obs;
  RxString callstatus = "Not connected".obs;

  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;
  var call_role = "audience".obs;
}
