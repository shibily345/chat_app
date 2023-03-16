import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/values/colors.dart';
import 'controller.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              SizedBox(
                height: Get.width * 0.2,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "${controller.state.to_avatar.value}"))),
                width: Get.width * 0.9,
                height: Get.height * 0.7,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                          color: Colors.white.withOpacity(0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(
                                text: "${controller.state.calltime.value}",
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${controller.state.to_avatar.value}")),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              textWidget(
                                text: "${controller.state.to_name.value}",
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          )),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  _fungButton(
                      Colors.white,
                      Icon(
                        controller.state.openMicrophone.value
                            ? Iconsax.microphone_slash
                            : Iconsax.microphone,
                        size: 30,
                      ),
                      75,
                      controller.state.openMicrophone.value ? "Mout" : "Speak",
                      () {}),
                  _fungButton(
                    controller.state.isJoined.value ? Colors.red : Colors.green,
                    Icon(
                      controller.state.isJoined.value
                          ? Iconsax.call_remove
                          : Iconsax.call,
                      color: white,
                      size: 30,
                    ),
                    95,
                    controller.state.isJoined.value ? "Disconnect" : "Connect",
                    controller.state.isJoined.value
                        ? controller.leaveChannel
                        : controller.joinChannel,
                  ),
                  _fungButton(
                      Colors.white,
                      Icon(
                        controller.state.enableSpeaker.value
                            ? Iconsax.speaker4
                            : Icons.speaker_phone_rounded,
                        size: 30,
                      ),
                      75,
                      controller.state.enableSpeaker.value
                          ? "Speaker"
                          : "EarPice",
                      () {}),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
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
}
