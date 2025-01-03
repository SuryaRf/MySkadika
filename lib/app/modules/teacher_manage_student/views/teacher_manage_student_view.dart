import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_manage_student_controller.dart';

class TeacherManageStudentView extends GetView<TeacherManageStudentController> {
  const TeacherManageStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherManageStudentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherManageStudentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
