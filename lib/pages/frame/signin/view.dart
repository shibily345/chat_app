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
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/grid_0.jpg'), fit: BoxFit.cover)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  LoginWidget(
                    context,
                    460,
                    Column(
                      children: [
                        _buildLogo(),
                        _buildField(context,
                            logo: Logo(
                              Logos.google,
                              size: 30,
                            ),
                            text: 'Sign IN With Google', onPressed: () {
                          controller.handleSignin('google');
                        }),
                        _buildField(context,
                            onPressed: () {},
                            logo: Logo(
                              Logos.apple,
                              size: 30,
                            ),
                            text: 'Sign IN With Apple'),
                        _buildField(context,
                            onPressed: () {},
                            logo: Logo(
                              Logos.facebook_logo,
                              size: 30,
                            ),
                            text: 'Sign IN With faceBook'),
                        const SizedBox(
                          height: 20,
                        ),
                        textWidget(
                            text: 'All Ready Have an Account?', color: white),
                        SpButton(onPressed: () {}, title: 'LOG IN', context)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textWidget(
                      text: "OR",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: white),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginWidget(
                    context,
                    110,
                    Column(
                      children: [
                        _buildField(context,
                            logo: const Icon(Icons.phone),
                            text: "With Phone Number",
                            onPressed: () {})
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget LoginWidget(
    BuildContext context,
    double height,
    Widget items,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
      ),
      width: 350,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child:
                Container(color: Colors.white.withOpacity(0.2), child: items),
          )),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child:
          SizedBox(height: 70, child: SvgPicture.asset('assets/logo111.svg')),
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
        margin: const EdgeInsets.only(top: 25),
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 2, color: dblue),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo,
              const SizedBox(
                width: 10,
              ),
              textWidget(text: text, color: white)
            ],
          ),
        ),
      ),
    );
  }
}
