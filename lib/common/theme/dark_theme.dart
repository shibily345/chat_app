import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColorLight: Colors.grey,
    primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
    primaryColor: const Color(0xFFE8BD70),
    primarySwatch: Colors.yellow,
    indicatorColor: const Color.fromARGB(255, 255, 255, 255),
    splashColor: const Color.fromARGB(255, 21, 21, 21),
    shadowColor: const Color.fromARGB(221, 0, 0, 0),
    scaffoldBackgroundColor: const Color.fromARGB(255, 36, 36, 36),
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
    // textTheme: const TextTheme(
    //   labelLarge: lableTextStyle,
    //   labelMedium: lableTextStyle,
    //   labelSmall: lableTextStyle,
    //   bodyMedium: TextStyle(color: secondaryColor40DarkTheme),
    // ),
    ,
    iconTheme: const IconThemeData(color: primaryColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateColor.resolveWith((states) => primaryColor))),
    dialogTheme: DialogTheme(
      surfaceTintColor: primaryColor,
      iconColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // backgroundColor: Color.fromARGB(255, 21, 21, 21),
    ),
  );
}

// ThemeData darkTheme(BuildContext context) {
//   return ThemeData(
//     brightness: Brightness.dark,
//     primaryColorLight: Colors.grey,
//     primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
//     primaryColor: Color.fromARGB(255, 89, 255, 0),
//     primarySwatch: Colors.lightBlue,
//     indicatorColor: Color.fromARGB(255, 176, 255, 166),
//     splashColor: Color.fromARGB(248, 31, 142, 9),
//     shadowColor: const Color.fromARGB(32, 131, 128, 128),
//     scaffoldBackgroundColor: Color.fromARGB(255, 34, 40, 34),
//     // textTheme: const TextTheme(
//     //   labelLarge: lableTextStyle,
//     //   labelMedium: lableTextStyle,
//     //   labelSmall: lableTextStyle,
//     //   bodyMedium: TextStyle(color: secondaryColor40DarkTheme),
//     // ),
//   );
// }
