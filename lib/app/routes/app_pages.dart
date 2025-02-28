import 'package:get/get.dart';

import '../modules/detail_mapel/bindings/detail_mapel_binding.dart';
import '../modules/detail_mapel/views/detail_mapel_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/navigation_bar_student/bindings/navigation_bar_student_binding.dart';
import '../modules/navigation_bar_student/views/navigation_bar_student_view.dart';
import '../modules/student_exams/bindings/student_exams_binding.dart';
import '../modules/student_exams/views/student_exams_view.dart';
import '../modules/student_home/bindings/student_home_binding.dart';
import '../modules/student_home/views/student_home_view.dart';
import '../modules/student_mapel/bindings/student_mapel_binding.dart';
import '../modules/student_mapel/views/student_mapel_view.dart';
import '../modules/student_profile/bindings/student_profile_binding.dart';
import '../modules/student_profile/views/student_profile_view.dart';
import '../modules/student_task/bindings/student_task_binding.dart';
import '../modules/student_task/views/student_task_view.dart';
import '../modules/teacher_home/bindings/teacher_home_binding.dart';
import '../modules/teacher_home/views/teacher_home_view.dart';
import '../modules/teacher_manage_courses/bindings/teacher_manage_courses_binding.dart';
import '../modules/teacher_manage_courses/views/teacher_manage_courses_view.dart';
import '../modules/teacher_manage_exams/bindings/teacher_manage_exams_binding.dart';
import '../modules/teacher_manage_exams/views/teacher_manage_exams_view.dart';
import '../modules/teacher_manage_student/bindings/teacher_manage_student_binding.dart';
import '../modules/teacher_manage_student/views/teacher_manage_student_view.dart';
import '../modules/teacher_profile/bindings/teacher_profile_binding.dart';
import '../modules/teacher_profile/views/teacher_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
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
    GetPage(
      name: _Paths.NAVIGATION_BAR,
      page: () => const NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_MANAGE_STUDENT,
      page: () => const TeacherManageStudentView(),
      binding: TeacherManageStudentBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_MANAGE_COURSES,
      page: () => const TeacherManageCoursesView(),
      binding: TeacherManageCoursesBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_MANAGE_EXAMS,
      page: () => TeacherManageExamsView(),
      binding: TeacherManageExamsBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_PROFILE,
      page: () => const TeacherProfileView(),
      binding: TeacherProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MAPEL,
      page: () => const DetailMapelView(
        mapel: null,
      ),
      binding: DetailMapelBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BAR_STUDENT,
      page: () => const NavigationBarStudentView(),
      binding: NavigationBarStudentBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_TASK,
      page: () => const StudentTaskView(),
      binding: StudentTaskBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_EXAMS,
      page: () => const StudentExamsView(),
      binding: StudentExamsBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_PROFILE,
      page: () => const StudentProfileView(),
      binding: StudentProfileBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT_MAPEL,
      page: () => const StudentMapelView(),
      binding: StudentMapelBinding(),
    ),
  ];
}
