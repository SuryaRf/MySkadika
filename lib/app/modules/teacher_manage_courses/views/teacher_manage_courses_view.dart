import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_manage_courses_controller.dart';

class TeacherManageCoursesView extends GetView<TeacherManageCoursesController> {
  const TeacherManageCoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherManageCoursesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherManageCoursesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
