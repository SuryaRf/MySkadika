import 'package:get/get.dart';

import '../controllers/teacher_manage_exams_controller.dart';

class TeacherManageExamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherManageExamsController>(
      () => TeacherManageExamsController(),
    );
  }
}
