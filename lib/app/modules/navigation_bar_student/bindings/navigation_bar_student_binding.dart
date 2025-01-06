import 'package:get/get.dart';

import '../controllers/navigation_bar_student_controller.dart';

class NavigationBarStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationBarStudentController>(
      () => NavigationBarStudentController(),
    );
  }
}
