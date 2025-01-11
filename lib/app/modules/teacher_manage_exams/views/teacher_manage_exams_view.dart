import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/teacher_manage_exams_controller.dart';

class TeacherManageExamsView extends StatelessWidget {
  final TeacherManageExamsController controller = Get.put(TeacherManageExamsController());

  TeacherManageExamsView({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Exam Title'),
              onChanged: (value) => controller.title.value = value,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question Text'),
            ),
            const SizedBox(height: 20),
            ...List.generate(4, (index) {
              return TextField(
                controller: optionControllers[index],
                decoration: InputDecoration(labelText: 'Option ${index + 1}'),
              );
            }),
            const SizedBox(height: 20),
            TextField(
              controller: correctAnswerController,
              decoration: const InputDecoration(labelText: 'Correct Answer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addQuestion(
                  questionController.text,
                  optionControllers.map((e) => e.text).toList(),
                  correctAnswerController.text,
                );
                questionController.clear();
                optionControllers.forEach((e) => e.clear());
                correctAnswerController.clear();
              },
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                'Total Questions: ${controller.questions.length}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: () => controller.saveExam(),
              child: const Text('Save Exam'),
            ),
          ],
        ),
      ),
    );
  }
}
