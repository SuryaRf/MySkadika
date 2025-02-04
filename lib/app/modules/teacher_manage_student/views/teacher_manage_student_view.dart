import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskadika/app/modules/teacher_manage_student/views/teacher_add_student.dart';
import '../controllers/teacher_manage_student_controller.dart';

class TeacherManageStudentView extends GetView<TeacherManageStudentController> {
  const TeacherManageStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeacherManageStudentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Siswa',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white,),
            onPressed: () => controller.refreshData(),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.green,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(TeacherAddStudent())),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.students.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_off, size: 100, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'Tidak ada data siswa',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.students.length,
            itemBuilder: (context, index) {
              final student = controller.students[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Text(
                      student.name.isNotEmpty
                          ? student.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'NIS: ${student.nis}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        'Kelas: ${student.classes}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Detail Siswa',
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama: ${student.name}'),
                          Text('Alamat: ${student.address}'),
                          Text('Kelas: ${student.classes}'),
                          Text('NIS: ${student.nis}'),
                        ],
                      ),
                      confirm: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Tutup', style: TextStyle(color: Colors.white),),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
