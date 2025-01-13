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
        title: const Text('Student Exams'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
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
        );
      }),
    );
  }
}

// Detail View: Menampilkan soal dan memungkinkan siswa memilih jawaban
class ExamDetailView extends StatelessWidget {
  final String examId;
  final StudentExamsController controller = Get.find<StudentExamsController>();

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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...((exam['questions'] ?? []).map<Widget>((question) {
                final questionId = question['questionId'] ?? ''; // Ensure questionId is not null
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['questionText'] ?? 'No question text', // Provide default text
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Column(
                        children: ((question['options'] ?? []).where((option) => option != null).map<Widget>((option) {
                          final isSelected = (controller.selectedAnswers[questionId] ?? '') == (option ?? '');

                          return RadioListTile<String>(
                            title: Text(
                              option ?? 'No option', // Provide default text
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            value: option ?? '', // Ensure value is not null
                            groupValue: controller.selectedAnswers[questionId] ?? '', // Default to empty string if null
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedAnswers[questionId] = value;
                              }
                            },
                            selected: isSelected,
                            selectedTileColor: Colors.green,
                            tileColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }).toList()),
                      );
                    }),
                    const Divider(),
                  ],
                );
              }).toList()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.submitAnswers(examId),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
