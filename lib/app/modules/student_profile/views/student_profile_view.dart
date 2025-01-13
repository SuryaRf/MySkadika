import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_profile_controller.dart';

class StudentProfileView extends GetView<StudentProfileController> {
  const StudentProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
