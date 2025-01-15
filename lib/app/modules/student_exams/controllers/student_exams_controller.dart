import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentExamsController extends GetxController {
 final exams = [].obs; // List ujian yang diambil dari Firestore
  final selectedAnswers = <String, String>{}.obs; // Jawaban siswa per soal (key: questionId, value: answer)
  final isLoading = true.obs;
  late String nis; // Deklarasi nis sebagai variabel instance
  @override
  void onInit() {
    super.onInit();
    // Ambil NIS dari GetStorage dan simpan di variabel instance
    final storage = GetStorage();
    nis = storage.read('nis') ?? ''; // Default kosong jika tidak ada
    fetchExams();
  }

  Future<void> fetchExams() async {
    try {
      isLoading.value = true;
      final snapshot =
          await FirebaseFirestore.instance.collection('exams').get();
      exams.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'questions': data['questions'] ?? [], // Pastikan questions tidak null
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch exams: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void submitAnswers(String examId) async {
  try {
    final exam = exams.firstWhere((e) => e['code'] == examId);

    int correctCount = 0;
    int incorrectCount = 0;

    for (var question in exam['questions']) {
      final questionId = question['questionId'];
      final correctAnswer = question['correctAnswer'];

      // Check if questionId and correctAnswer are not null
      if (questionId != null && correctAnswer != null) {
        final selectedAnswer = selectedAnswers[questionId];

        // Compare selected answer with correct answer
        if (selectedAnswer == correctAnswer) {
          correctCount++;
        } else {
          incorrectCount++;
        }
      } else {
        // Handle the case where questionId or correctAnswer is null
        Get.snackbar('Warning', 'Question ID or correct answer is missing for a question.');
      }
    }

    // Simpan hasil jawaban ke Firestore
    await FirebaseFirestore.instance.collection('results').add({
      'examId': examId,
      'studentId': nis,
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'submittedAt': Timestamp.now(),
    });

    Get.snackbar('Success', 'Your answers have been submitted!');
  } catch (e) {
    Get.snackbar('Error', 'Failed to submit answers: $e');
  }
}}