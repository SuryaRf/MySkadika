import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentExamsController extends GetxController {
  final exams = [].obs; // List ujian yang diambil dari Firestore
  final selectedAnswers = <String, String>{}
      .obs; // Jawaban siswa per soal (key: questionId, value: answer)
  final isLoading = true.obs;
  late String nis; // Deklarasi nis sebagai variabel instance
  final currentQuestionIndex = 0.obs;
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

      // Ambil semua hasil ujian yang sudah dikerjakan siswa dengan nis ini
      final resultsSnapshot = await FirebaseFirestore.instance
          .collection('results')
          .where('studentId', isEqualTo: nis)
          .get();

      // Buat daftar examId yang sudah dikerjakan
      final completedExamIds = resultsSnapshot.docs
          .map((doc) => doc.data()['examId'] as String)
          .toList();

      // Ambil semua ujian dari koleksi exams
      final examsSnapshot =
          await FirebaseFirestore.instance.collection('exams').get();

      // Filter ujian yang belum dikerjakan
      exams.value = examsSnapshot.docs
          .where((doc) => !completedExamIds.contains(doc.data()['code']))
          .map((doc) {
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

  Future<void> refreshData() async {
    await fetchExams();
  }

  void nextQuestion() {
    currentQuestionIndex.value++;
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
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
          Get.snackbar('Warning',
              'Question ID or correct answer is missing for a question.');
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
      fetchExams();
      Get.back();
      Get.snackbar('Success', 'Your answers have been submitted!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit answers: $e');
    }
  }
}
