import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/student_home_controller.dart';

class StudentHomeView extends GetView<StudentHomeController> {
  const StudentHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: () {
    final storage = GetStorage();
    print('GetStorage Data:');
    storage.getKeys().forEach((key) {
      print('$key: ${storage.read(key)}');
    });
  },),
      appBar: AppBar(
        title: const Text('StudentHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudentHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
