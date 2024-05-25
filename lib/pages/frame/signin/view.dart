import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hay_chat/common/colors.dart';

import 'package:hay_chat/common/widgets.dart';
import 'package:hay_chat/pages/frame/signin/controller.dart';
import 'package:hay_chat/pages/message/view.dart';
import 'package:icons_plus/icons_plus.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                _buildLogo(),
                SizedBox(
                  height: 100,
                ),
                _buildField(context,
                    logo: Logo(
                      Logos.google,
                      size: 20,
                    ),
                    text: 'Sign in with Google', onPressed: () {
                  controller.handleSignin('google');
                }),
                _buildField(context,
                    onPressed: () {},
                    logo: Logo(
                      Logos.apple,
                      size: 20,
                    ),
                    text: 'Sign in with Apple'),
                _buildField(context,
                    onPressed: () {},
                    logo: Logo(
                      Logos.facebook_logo,
                      size: 20,
                    ),
                    text: 'Sign in with FaceBook'),
                const SizedBox(
                  height: 20,
                ),
                textWidget(text: 'All ready have an account?', color: black),
                SpButton(onPressed: () {}, title: 'Log in', context),
                const SizedBox(
                  height: 10,
                ),
                // textWidget(
                //     text: "OR",
                //     fontSize: 20,
                //     fontWeight: FontWeight.normal,
                //     color: white),
                // const SizedBox(
                //   height: 10,
                // ),
                // _buildField(context,
                //     logo: const Icon(Icons.phone),
                //     text: "With Phone Number",
                //     onPressed: () {}),
              ],
            ),
          ),
        ));
  }

  // Widget loginWidget(
  //   BuildContext context,
  //   Widget items,
  // ) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 30),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25),
  //     ),
  //     // width: 350,
  //     // height: height,
  //     child: ClipRRect(
  //         borderRadius: BorderRadius.circular(35),
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //           child: Padding(
  //             padding: const EdgeInsets.all(28.0),
  //             child: items,
  //           ),
  //         )),
  //   );
  // }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child:
          SizedBox(height: 70, child: SvgPicture.asset('assets/HAYlogo.svg')),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required Widget logo,
    required String text,
    required Function onPressed,
  }) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 40,
        width: 250,
        decoration: BoxDecoration(
          color: Color.fromARGB(183, 181, 180, 180),
          borderRadius: BorderRadius.circular(15),
          // border:
          //     Border.all(width: 2, color: Color.fromARGB(186, 138, 204, 248)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo,
              const SizedBox(
                width: 10,
              ),
              textWidget(text: text, color: black)
            ],
          ),
        ),
      ),
    );
  }
}
