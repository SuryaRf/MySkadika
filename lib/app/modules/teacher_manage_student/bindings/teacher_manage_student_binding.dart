import 'package:get/get.dart';

import '../controllers/teacher_manage_student_controller.dart';

class TeacherManageStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherManageStudentController>(
      () => TeacherManageStudentController(),
    );
  }
}
