import 'package:flutter/material.dart';

// import 'package:get/get.dart';
import 'package:myskadika/app/data/models/nav_model.dart';
import 'package:myskadika/app/data/models/navbar_student.dart';
import 'package:myskadika/app/modules/student_exams/views/student_exams_view.dart';
import 'package:myskadika/app/modules/student_home/views/student_home_view.dart';
import 'package:myskadika/app/modules/student_mapel/views/student_mapel_view.dart';
import 'package:myskadika/app/modules/student_profile/views/student_profile_view.dart';
import 'package:myskadika/app/modules/student_task/views/student_task_view.dart';
import '../../../data/models/navbar.dart';

// import '../controllers/navigation_bar_controller.dart';

class NavigationBarStudentView extends StatefulWidget {
  
  const NavigationBarStudentView({Key? key}) : super(key: key);

  @override
  State<NavigationBarStudentView> createState() => _NavigationBarStudentViewState();
}

class _NavigationBarStudentViewState extends State<NavigationBarStudentView> {
  
  final homeNavKey = GlobalKey<NavigatorState>();
  final taskNavKey = GlobalKey<NavigatorState>();
  final examsNavKey = GlobalKey<NavigatorState>();
  final mapelNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  
  int selectedTab = 0;
  late List<NavModel> items;

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: const StudentHomeView(), navKey: homeNavKey),
      NavModel(page:  StudentTaskView(), navKey: taskNavKey),
      NavModel(page: const StudentExamsView(), navKey: examsNavKey),
      NavModel(page:  StudentMapelView(), navKey: mapelNavKey),
      NavModel(page: const StudentProfileView(), navKey: profileNavKey),
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
        bottomNavigationBar: NavbarStudent(
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