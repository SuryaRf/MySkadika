import 'package:get/get.dart';

import '../controllers/student_mapel_controller.dart';

class StudentMapelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentMapelController>(
      () => StudentMapelController(),
    );
  }
}
