import 'dart:ffi';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/values/colors.dart';
import 'controller.dart';

class VideoCallPage extends GetView<VideoCallController> {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.width * 0.2,
              ),
              textWidget(
                  text: "${controller.state.to_name.value}",
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: white),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: gray,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: Get.width * 0.9,
                  height: Get.height * 0.85,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: gray,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: Get.width * 0.9,
                        height: Get.height * 0.85,
                        child: _remoteVideo(),
                      ),
                      Positioned(
                        bottom: 150,
                        right: 150,
                        child: textWidget(
                          text: "${controller.state.calltime.value}",
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 15,
                        child: Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: black,
                          ),
                          child: _localPreview(),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            _fungButton(
                              controller.state.isJoined.value
                                  ? Colors.red
                                  : Colors.green,
                              Icon(
                                controller.state.isJoined.value
                                    ? Iconsax.call_remove
                                    : Iconsax.call,
                                color: white,
                                size: 30,
                              ),
                              75,
                              controller.state.isJoined.value
                                  ? "Disconnect"
                                  : "Connect",
                              controller.state.isJoined.value
                                  ? controller.leaveChannel
                                  : controller.joinChannel,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            _fungButton(
                                Colors.white,
                                Icon(
                                  controller.state.enableVideo.value
                                      ? Iconsax.video_slash
                                      : Icons.speaker_phone_rounded,
                                  size: 30,
                                ),
                                75,
                                controller.state.enableVideo.value
                                    ? "Video Off"
                                    : "Video On",
                                () {}),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  GestureDetector _fungButton(
      Color color, Widget icon, double size, String name, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Column(
        children: [
          Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: icon),
          SizedBox(
            height: 10,
          ),
          textWidget(text: name, color: white)
        ],
      ),
    );
  }

  Widget _localPreview() {
    if (controller.state.isJoined == true) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (controller.state.remoteUid.value != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: controller.state.remoteUid.value),
          connection: RtcConnection(channelId: "chatApp"),
        ),
      );
    } else {
      String msg = '';
      if (controller.state.isJoined == true)
        msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }
}
