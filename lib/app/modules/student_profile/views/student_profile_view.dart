import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/student_profile_controller.dart';

class StudentProfileView extends GetView<StudentProfileController> {
  const StudentProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentProfileController());

    // Panggil fungsi untuk mengambil data profil
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Siswa', style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.green, // Warna AppBar
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Container(
            height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
            child: Column(
              children: [
                // Header dengan gambar dan nama
                Stack(
                  children: [
                    Container(
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(
                            'lib/assets/logo.png',), // Gambar placeholder
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              controller.name.value,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                           
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
            
                // Informasi detail profil
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        icon: Icons.sim_card,
                        title: 'NIS',
                        value: controller.nis.value,
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.person,
                        title: 'Jenis Kelamin',
                        value: controller.gender.value,
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.class_,
                        title: 'Kelas',
                        value: controller.classes.value,
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.home,
                        title: 'Alamat',
                        value: controller.address.value,
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.phone,
                        title: 'Nomor HP',
                        value: controller.phoneNumber.value,
                      ),
                    ],
                  ),
                ),
            
              // Tombol Logout
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Widget untuk kartu informasi
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Icon(
                icon,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
