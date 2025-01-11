import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeacherManageExamsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final title = ''.obs;
  final questions = <Map<String, dynamic>>[].obs;

  void addQuestion(String questionText, List<String> options, String correctAnswer) {
    final questionId = DateTime.now().millisecondsSinceEpoch.toString();
    questions.add({
      "questionId": questionId,
      "questionText": questionText,
      "options": options,
      "correctAnswer": correctAnswer,
    });
  }

  Future<void> saveExam() async {
    final examId = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestore.collection('exams').doc(examId).set({
        "examId": examId,
        "title": title.value,
        "questions": questions,
      });
      Get.snackbar("Success", "Exam has been created successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to create exam: $e");
    }
  }
}
