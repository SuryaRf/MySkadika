import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_task_controller.dart';

class StudentTaskView extends GetView<StudentTaskController> {
  const StudentTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentTaskView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentTaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
