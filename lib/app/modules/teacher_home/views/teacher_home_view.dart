import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
import 'package:myskadika/app/modules/teacher_manage_student/views/teacher_manage_student_view.dart';

import '../controllers/teacher_home_controller.dart';

class TeacherHomeView extends GetView<TeacherHomeController> {
  const TeacherHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
          width: width,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: width * 0.03, top: height * 0.02, right: width * 0.02),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Apa yang ingin kamu lakukan?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: height * 0.23,
          width: width * 0.95,
          child: Card(
            color: Colors.green.shade50,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.2,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Background untuk placeholder
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(
                            'lib/assets/icon_teacher.png'), // Path gambar
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Jarak antara gambar dan teks
                  // Bagian kanan untuk teks dan tombol
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pantau Data Siswa",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: const Color(0xFF388E3C),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Text(
                          "Permudah kegiatan belajar mengajar\ndengan aplikasi ini",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size.fromHeight(43),
                          ),
                          onPressed: () {
                            // Aksi navigasi saat tombol ditekan
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TeacherManageStudentView()),
                            );
                          },
                          child: const Text(
                            "Pantau Data Siswa Sekarang",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    )));
  }
}
