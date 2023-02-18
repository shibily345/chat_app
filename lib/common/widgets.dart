import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hay_chat/common/colors.dart';

Widget textWidget(
    {required String text,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = black}) {
  return Text(
    text,
    style: GoogleFonts.firaSans(
        fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}
