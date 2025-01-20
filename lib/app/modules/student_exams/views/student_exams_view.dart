// Main View: Menampilkan daftar ujian (cover ujian)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/student_exams_controller.dart';

class StudentExamsView extends GetView<StudentExamsController> {
  const StudentExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentExamsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ujian Siswa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.builder(
            itemCount: controller.exams.length,
            itemBuilder: (context, index) {
              final exam = controller.exams[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    exam['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Code: ${exam['code']}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.to(() => ExamDetailView(examId: exam['code']));
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

// Detail View: Menampilkan soal dan memungkinkan siswa memilih jawaban
class ExamDetailView extends StatelessWidget {
  final String examId;
  final StudentExamsController controller = Get.find();
  ExamDetailView({required this.examId, super.key});

  @override
  Widget build(BuildContext context) {
    final exam = controller.exams.firstWhere((e) => e['code'] == examId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam: ${exam['title']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questions:',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...((exam['questions'] ?? []).map<Widget>((question) {
                final questionId = question['questionId'] ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['questionText'] ?? 'No question text',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Column(
                        children:
                            (question['options'] ?? []).map<Widget>((option) {
                          return RadioListTile<String>(
                            title: Text(option ?? 'No option'),
                            value: option ?? '',
                            groupValue: controller.selectedAnswers[questionId],
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedAnswers[questionId] = value;
                              }
                            },
                          );
                        }).toList(),
                      );
                    }),
                    const Divider(),
                  ],
                );
              }).toList()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.submitAnswers(examId);

                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
