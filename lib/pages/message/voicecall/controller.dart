import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/apis/chat.dart';
import 'package:hay_chat/common/entities/chat.dart';
import 'package:hay_chat/common/routes/names.dart';

import 'package:hay_chat/pages/message/voicecall/state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/store/user.dart';
import '../../../common/values/server.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final state = VoiceCallState();
  final player = AudioPlayer();
  String appid = APPID;
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.token;
  late final RtcEngine engine;
  ChannelProfileType channelProfileType =
      ChannelProfileType.channelProfileCommunication;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    state.to_name.value = data["to_name"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    state.call_role.value = data["call_role"] ?? "";
    state.doc_id.value = data["doc_id"] ?? "";
    state.to_token.value = data["to_token"] ?? "";
    print("....your name id ${state.to_name.value}");
    initEngine();
  }

  Future<void> initEngine() async {
    player.setAsset("assets/ringno1.mp3");
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appid,
    ));

    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err:$err, ,msg:$msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elasped) {
        print('onConnection ${connection.toJson()}');
        state.isJoined.value = true;
      },
      onUserJoined:
          (RtcConnection connection, int remoteUid, int elasped) async {
        await player.pause();
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) async {
        print('.........user left..............');
        state.isJoined.value = false;
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) async {
        print('time.............');
        print(stats.duration);
      },
    ));
    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
        scenario: AudioScenarioType.audioScenarioGameStreaming);
    await joinChannel();
    if (state.call_role == "anchor") {
      await sendNotification("");
      await player.play();
    }
  }

  Future<void> sendNotification(String type) async {
    CallRequestEntity callRequestEntity = CallRequestEntity();
    callRequestEntity.call_type = type;
    callRequestEntity.to_token = state.to_token.value;
    callRequestEntity.to_avatar = state.to_avatar.value;
    callRequestEntity.doc_id = state.doc_id.value;
    callRequestEntity.to_avatar = state.to_avatar.value;
    callRequestEntity.to_name = state.to_name.value;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    if (res.data == 0) {
      print(
          "notification success;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    } else {
      print("could not send notification");
    }
  }

  Future<String> getToken() async {
    if (state.call_role == "anchor") {
      state.channelId.value = md5
          .convert(utf8.encode("${profile_token}_${state.to_token}"))
          .toString();
    } else {
      state.channelId.value = md5
          .convert(utf8.encode("${state.to_token}_$profile_token"))
          .toString();
    }
    CallTokenRequestEntity callTokenRequestEntity = CallTokenRequestEntity();
    callTokenRequestEntity.channel_name = state.channelId.value;
    print(
        "_____________________________________OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO______________------------< ID : ------------------------${state.channelId.value}");
    print(
        "_____________________________________OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO______________------------< ID : ------------------------${UserStore.to.token}");
    var res = await ChatAPI.call_token(params: callTokenRequestEntity);
    if (res.code == 0) {
      return res.data!;
    }
    return "";
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    String token = await getToken();
    if (token.isEmpty) {
      EasyLoading.dismiss();
      Get.back();
      return;
    }
    await engine.joinChannel(
      token: token,
      channelId: state.channelId.value,
      uid: 0,
      options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster),
    );
    EasyLoading.dismiss();
  }

  Future<void> leaveChannel() async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    Get.back();
  }

  Future<void> _dispose() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}
