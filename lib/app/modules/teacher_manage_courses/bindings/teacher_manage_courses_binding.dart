import 'package:get/get.dart';

import '../controllers/teacher_manage_courses_controller.dart';

class TeacherManageCoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherManageCoursesController>(
      () => TeacherManageCoursesController(),
    );
  }
}
