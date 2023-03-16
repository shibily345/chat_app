import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hay_chat/common/colors.dart';
import 'package:hay_chat/common/values/colors.dart';
import 'package:iconsax/iconsax.dart';

Widget textWidget(
    {required String text,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black}) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: GoogleFonts.firaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget SpButton(
  BuildContext context, {
  required String title,
  required Function onPressed,
}) {
  return InkWell(
    onTap: () => onPressed(),
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 10,
        //     offset: const Offset(10, 10),
        //     color: Theme.of(context).splashColor,
        //   ),
        // ],
        gradient: const LinearGradient(
            colors: [sgreen, blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: textWidget(
          text: title,
        ),
      ),
    ),
  );
}

Widget BlurContainer(
  BuildContext context,
  double height,
  double width,
  Widget items,
) {
  return Container(
    width: width,
    height: height,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.white.withOpacity(0.2), child: items),
        )),
  );
}

AppBar buildAppar(Widget leading, Widget title, Widget end, Color color) {
  return AppBar(
    foregroundColor: Colors.black,
    elevation: 0,
    backgroundColor: color,
    leading: leading,
    title: title,
    actions: [
      end,
      SizedBox(
        width: 20,
      )
    ],
  );
}
