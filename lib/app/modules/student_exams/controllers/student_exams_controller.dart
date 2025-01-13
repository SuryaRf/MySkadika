import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentExamsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final examData = {}.obs;

  Future<void> fetchExam(String examId) async {
    isLoading.value = true;
    try {
      final snapshot = await firestore.collection('exams').doc(examId).get();
      examData.value = snapshot.data()!;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch exam: $e");
    }
    isLoading.value = false;
  }

  Future<void> submitAnswers(String studentId, String examId,
      List<Map<String, dynamic>> answers) async {
    int correct = 0;
    int incorrect = 0;

    for (var answer in answers) {
      final question = examData['questions'].firstWhere(
        (q) => q['questionId'] == answer['questionId'],
      );
      if (answer['selectedAnswer'] == question['correctAnswer']) {
        correct++;
        answer['isCorrect'] = true;
      } else {
        incorrect++;
        answer['isCorrect'] = false;
      }
    }

    try {
      await firestore.collection('studentAnswers').doc(studentId).set({
        "studentId": studentId,
        "examId": examId,
        "answers": answers,
        "score": {
          "correct": correct,
          "incorrect": incorrect,
        }
      });
      Get.snackbar("Success", "Answers submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit answers: $e");
    }
  }
}
