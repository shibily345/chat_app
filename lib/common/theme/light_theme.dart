import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      primaryColorLight: const Color.fromARGB(255, 221, 220, 220),
      primaryColor: Color.fromARGB(255, 13, 13, 13),
      primarySwatch: Colors.grey,
      indicatorColor: const Color.fromARGB(255, 0, 0, 0),
      splashColor: Color.fromARGB(255, 180, 180, 180),
      shadowColor: const Color.fromARGB(255, 233, 227, 194),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      primaryColorDark: Colors.black,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      // textTheme: const TextTheme(
      //   labelLarge: lableTextStyle,
      //   labelMedium: lableTextStyle,
      //   labelSmall: lableTextStyle,
      //   bodyMedium: TextStyle(color: secondaryColor40LightTheme),
      // ),
      );
}
