import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: _headBar(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _headBar() {
    return Center();
  }
}
