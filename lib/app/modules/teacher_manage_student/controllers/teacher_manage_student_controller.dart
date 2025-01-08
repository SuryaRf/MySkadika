import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myskadika/app/data/models/student.dart';

class TeacherManageStudentController extends GetxController {
  var students = <Student>[].obs;
  var isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await _firestore.collection('students').get();
      students.value = snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching students: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchStudents();
  }
}
