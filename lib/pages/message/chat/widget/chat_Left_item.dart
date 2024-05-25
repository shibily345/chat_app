import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hay_chat/common/entities/entities.dart';
import 'package:intl/intl.dart';

Widget recivedText(Msgcontent item) {
  var dt =
      DateTime.fromMillisecondsSinceEpoch(item.addtime!.millisecondsSinceEpoch);

  var d12 = DateFormat('E hh:mm a').format(dt);
  return Container(
    padding: EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 240, minHeight: 40),
            child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    item.type == "text"
                        ? Text(
                            "${item.content}",
                            style: TextStyle(color: Colors.black),
                          )
                        : ConstrainedBox(
                            constraints:
                                BoxConstraints(minWidth: 240, minHeight: 200),
                            child: GestureDetector(
                                child: CachedNetworkImage(
                              imageUrl: "${item.content}",
                              height: 200,
                            )),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${d12}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 10),
                    )
                  ],
                )))
      ],
    ),
  );
}
