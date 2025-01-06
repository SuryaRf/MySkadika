import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_bar_student_controller.dart';

class NavigationBarStudentView extends GetView<NavigationBarStudentController> {
  const NavigationBarStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NavigationBarStudentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NavigationBarStudentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
