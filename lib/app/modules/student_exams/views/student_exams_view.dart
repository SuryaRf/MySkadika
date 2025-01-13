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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam['title'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...exam['questions'].map<Widget>((question) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question['questionText'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          ...question['options'].map<Widget>((option) {
                            return RadioListTile<String>(
                              title: Text(option),
                              value: option,
                              groupValue:
                                  controller.selectedAnswers[question['questionId']],
                              onChanged: (value) {
                                controller.selectedAnswers[question['questionId']] = value;
                              },
                            );
                          }).toList(),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.submitAnswers(exam['examId']),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
