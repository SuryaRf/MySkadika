import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/student_home/bindings/student_home_binding.dart';
import '../modules/student_home/views/student_home_view.dart';
import '../modules/teacher_home/bindings/teacher_home_binding.dart';
import '../modules/teacher_home/views/teacher_home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_HOME,
      page: () => const StudentHomeView(),
      binding: StudentHomeBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      binding: TeacherHomeBinding(),
    ),
  ];
}
