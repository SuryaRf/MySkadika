import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends GetView<NavigationBarController> {
  const NavigationBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationBarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationBarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
