import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/teacher_manage_student_controller.dart';

class TeacherManageStudentView extends GetView<TeacherManageStudentController> {
  const TeacherManageStudentView({super.key});
 

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(TeacherManageStudentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Siswa'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshData(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.students.isEmpty) {
          return const Center(
            child: Text(
              'Tidak ada data siswa',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(student.name[0]),
                ),
                title: Text(student.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NIS: ${student.nis}'),
                    Text('Kelas: ${student.classes}'),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Aksi ketika item ditekan
                  Get.snackbar(
                    'Detail Siswa',
                    'Nama: ${student.name}\nAlamat: ${student.address}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
