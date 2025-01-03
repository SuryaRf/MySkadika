import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_manage_exams_controller.dart';

class TeacherManageExamsView extends GetView<TeacherManageExamsController> {
  const TeacherManageExamsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherManageExamsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherManageExamsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
