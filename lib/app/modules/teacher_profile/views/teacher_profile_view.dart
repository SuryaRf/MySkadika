import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/teacher_profile_controller.dart';

class TeacherProfileView extends GetView<TeacherProfileController> {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherProfileController());

    // Panggil fungsi untuk mengambil data profil
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Guru'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profil Guru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Nama:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(controller.name.value),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('NIP:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(controller.nip.value),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Jenis Kelamin:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(controller.gender.value),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Alamat:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(controller.address.value),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Nomor HP:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(controller.phoneNumber.value),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
