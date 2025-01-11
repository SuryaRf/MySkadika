import 'package:flutter/material.dart';

// import 'package:get/get.dart';
import 'package:myskadika/app/data/models/nav_model.dart';
import 'package:myskadika/app/modules/teacher_home/views/teacher_home_view.dart';
import 'package:myskadika/app/modules/teacher_manage_courses/views/teacher_manage_courses_view.dart';
import 'package:myskadika/app/modules/teacher_manage_exams/views/teacher_manage_exams_view.dart';
import 'package:myskadika/app/modules/teacher_manage_student/views/teacher_manage_student_view.dart';
import 'package:myskadika/app/modules/teacher_profile/views/teacher_profile_view.dart';

import '../../../data/models/navbar.dart';

// import '../controllers/navigation_bar_controller.dart';

class NavigationBarView extends StatefulWidget {
  
  const NavigationBarView({Key? key}) : super(key: key);

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  
  final homeNavKey = GlobalKey<NavigatorState>();
  final manageStudentNavKey = GlobalKey<NavigatorState>();
  final manageCoursesNavKey = GlobalKey<NavigatorState>();
  final manageExamsNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  
  int selectedTab = 0;
  late List<NavModel> items;

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: const TeacherHomeView(), navKey: homeNavKey),
      NavModel(page:  TeacherManageStudentView(), navKey: manageStudentNavKey),
      NavModel(page: const TeacherManageCoursesView(), navKey: manageCoursesNavKey),
      NavModel(page:  TeacherManageExamsView(), navKey: manageExamsNavKey),
      NavModel(page: const TeacherProfileView(), navKey: profileNavKey),
    ];
  }

   @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page),
                      ];
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index].navKey.currentState?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}