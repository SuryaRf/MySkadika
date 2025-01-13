import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_mapel_controller.dart';

class StudentMapelView extends GetView<StudentMapelController> {
  const StudentMapelView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentMapelView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentMapelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
