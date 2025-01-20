import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/teacher_manage_exams_controller.dart';

class TeacherManageExamsView extends StatelessWidget {
  final TeacherManageExamsController controller = Get.put(TeacherManageExamsController());

  final TextEditingController examTitleController = TextEditingController();
  final TextEditingController examCodeController = TextEditingController();

  TeacherManageExamsView({super.key}) {
    controller.fetchExams(); // Memanggil fetchExams saat widget dibuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Manage Exams', style: TextStyle(color: Colors.white),),
      ),
      body: Obx(() {
        if (controller.exams.isEmpty) {
          return const Center(
            child: Text('No exams available'),
          );
        }
        return ListView.builder(
          itemCount: controller.exams.length,
          itemBuilder: (context, index) {
            final exam = controller.exams[index];
            return ListTile(
              title: Text(exam['title']),
              subtitle: Text('Code: ${exam['code']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Get.to(() => ExamDetailView(examCode: exam['code']));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExamDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddExamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: examTitleController,
                decoration: const InputDecoration(labelText: 'Exam Title'),
              ),
              TextField(
                controller: examCodeController,
                decoration: const InputDecoration(labelText: 'Exam Code'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.addExam(examTitleController.text, examCodeController.text);
                examTitleController.clear();
                examCodeController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class ExamDetailView extends StatelessWidget {
  final String examCode;
  final TeacherManageExamsController controller = Get.find();

  final TextEditingController questionController = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());

  ExamDetailView({required this.examCode, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Code: $examCode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    examCode,
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
            ],
          ),
        ),
      ),
    );
  }
}
