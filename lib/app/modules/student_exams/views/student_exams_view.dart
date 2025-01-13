import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_exams_controller.dart';

class StudentExamsView extends GetView<StudentExamsController> {
  const StudentExamsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentExamsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentExamsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
