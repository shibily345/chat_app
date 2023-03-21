import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hay_chat/common/entities/entities.dart';

Widget chatRightItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 240, minHeight: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.2),
                      // gradient: LinearGradient(colors: [
                      //   Color.fromARGB(255, 210, 211, 211),
                      //   Color.fromARGB(255, 67, 207, 245).withOpacity(0.2),
                      //   Color.fromARGB(255, 151, 221, 247).withOpacity(0.2),
                      //   Color.fromARGB(255, 254, 255, 254).withOpacity(0.2),
                      // ], transform: GradientRotation(90)),
                      borderRadius: BorderRadius.circular(10),
                      //border: Border.all()
                    ),
                    child: item.type == "text"
                        ? Text("${item.content}")
                        : ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: 240, minHeight: 300),
                            child: GestureDetector(
                                child: CachedNetworkImage(
                              imageUrl: "${item.content}",
                              height: 40,
                            )),
                          )),
              ),
            ))
      ],
    ),
  );
}
