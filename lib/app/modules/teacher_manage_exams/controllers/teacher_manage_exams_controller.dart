import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeacherManageExamsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final exams = <Map<String, dynamic>>[].obs;

  // Menambahkan ujian baru
  Future<void> addExam(String title, String code) async {
    try {
      await firestore.collection('exams').doc(code).set({
        "title": title,
        "code": code,
        "questions": [], // Inisialisasi dengan array kosong untuk soal
      });
      exams.add({"title": title, "code": code});
      Get.snackbar("Success", "Exam added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add exam: $e");
    }
  }

  // Menambahkan soal ke ujian tertentu
  Future<void> addQuestion(String examCode, String questionText, List<String> options,
      String correctAnswer) async {
    try {
      final docRef = firestore.collection('exams').doc(examCode);
      final exam = await docRef.get();
      if (exam.exists) {
        final questions = List<Map<String, dynamic>>.from(exam.data()?['questions'] ?? []);
        questions.add({
          "questionText": questionText,
          "options": options,
          "correctAnswer": correctAnswer,
        });
        await docRef.update({"questions": questions});
        Get.snackbar("Success", "Question added successfully");
      } else {
        Get.snackbar("Error", "Exam not found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add question: $e");
    }
  }

  // Mengambil daftar ujian
  Future<void> fetchExams() async {
    try {
      final querySnapshot = await firestore.collection('exams').get();
      exams.value = querySnapshot.docs
          .map((doc) => {"title": doc['title'], "code": doc['code']})
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch exams: $e");
    }
  }
}
