import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_mapel_controller.dart';

class DetailMapelView extends GetView<DetailMapelController> {
  const DetailMapelView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailMapelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailMapelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
