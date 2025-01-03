import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_profile_controller.dart';

class TeacherProfileView extends GetView<TeacherProfileController> {
  const TeacherProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
