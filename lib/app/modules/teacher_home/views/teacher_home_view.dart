import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myskadika/app/modules/detail_mapel/controllers/detail_mapel_controller.dart';
import 'package:myskadika/app/modules/detail_mapel/views/detail_mapel_view.dart';
// import 'package:iconly/iconly.dart';
import 'package:myskadika/app/modules/teacher_manage_student/views/teacher_manage_student_view.dart';

import '../controllers/teacher_home_controller.dart';

class TeacherHomeView extends GetView<TeacherHomeController> {
  const TeacherHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final TeacherHomeController controller = Get.put(TeacherHomeController());
    final DetailMapelController detailMapelController =
        Get.put(DetailMapelController());
    var width = Get.width;
    var height = Get.height;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final storage = GetStorage();
      //     print('GetStorage Data:');
      //     storage.getKeys().forEach((key) {
      //       print('$key: ${storage.read(key)}');
      //     });
      //   },
      // ),
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
                    left: width * 0.03,
                    top: height * 0.02,
                    right: width * 0.02),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                            color: Colors
                                .transparent, // Background untuk placeholder
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'lib/assets/icon_teacher.png'), // Path gambar
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Jarak antara gambar dan teks
                        // Bagian kanan untuk teks dan tombol
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pantau Data Siswa",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
              SizedBox(
                height: 20,
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return RefreshIndicator(
                  onRefresh: controller.refreshData,
                  child: SizedBox(
                    height: 430,
                    child: GridView.builder(
                      itemCount: controller.mapel.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final mapel = controller.mapel[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailMapelView(mapel: mapel),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Gambar Mapel
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    child: Image.asset(
                                      'lib/assets/mapel.jpg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // Nama Mapel dan Informasi
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mapel.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines:
                                              2, // Membatasi hingga 2 baris
                                          overflow: TextOverflow
                                              .ellipsis, // Mengganti overflow dengan ellipsis
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          controller.mapel[index].name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(), // Memberikan ruang agar posisi tombol tetap di bawah
                                  // Tombol Arah
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_right_rounded,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
