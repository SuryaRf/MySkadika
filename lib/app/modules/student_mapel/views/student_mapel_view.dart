import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../detail_mapel/views/detail_mapel_view.dart';
import '../controllers/student_mapel_controller.dart';

class StudentMapelView extends GetView<StudentMapelController> {
  const StudentMapelView({super.key});
  @override
  Widget build(BuildContext context) {
    final StudentMapelController controller = Get.put(StudentMapelController());
   return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mapel',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
       
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('mapel').snapshots(),
          builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
           if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
            return SafeArea(child: SingleChildScrollView(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
                  child: RefreshIndicator(
                    onRefresh: controller.refreshData,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                              maxLines: 2, // Membatasi hingga 2 baris
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
                                              borderRadius: BorderRadius.circular(10),
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
                    ),
                  ),
                );
              }),
            ));
          }
        ));
  }
}
