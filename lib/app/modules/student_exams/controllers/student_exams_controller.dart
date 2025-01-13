import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class StudentExamsController extends GetxController {
  final exams = [].obs; // List ujian yang diambil dari Firestore
  final selectedAnswers = {}.obs; // Jawaban siswa per soal
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExams();
  }

  Future<void> fetchExams() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('exams').get();
      exams.value = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch exams: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void submitAnswers(String examId) async {
    try {
      // Ambil data ujian berdasarkan examId
      final exam = exams.firstWhere((e) => e['examId'] == examId);

      // Hitung jumlah benar dan salah
      int correctCount = 0;
      int incorrectCount = 0;
      for (var question in exam['questions']) {
        final questionId = question['questionId'];
        final correctAnswer = question['correctAnswer'];
        if (selectedAnswers[questionId] == correctAnswer) {
          correctCount++;
        } else {
          incorrectCount++;
        }
      }

      // Simpan hasil jawaban ke Firestore
      await FirebaseFirestore.instance.collection('results').add({
        'examId': examId,
        'studentId': 'student123', // Ganti dengan ID siswa saat login
        'correctCount': correctCount,
        'incorrectCount': incorrectCount,
        'submittedAt': Timestamp.now(),
      });

      Get.snackbar('Success', 'Your answers have been submitted!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit answers: $e');
    }
  }
}
