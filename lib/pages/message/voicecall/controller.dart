import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
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
  final profile_token = UserStore.to.profile.token;
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
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    await engine.joinChannel(
      token:
          "007eJxTYFBamsXCNfGWwEGjZyULWTT3CH78vMc5zzc11Pn7DBHn2+sUGJKSDI3NLJNS0tKMk0zSEo2TzAwsU82TUs3MDFKMUk2T87YKpDQEMjI8ZvzHyMgAgSA+O0NyRmKJY0EBAwMAdMogVg==",
      channelId: "chatApp",
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
