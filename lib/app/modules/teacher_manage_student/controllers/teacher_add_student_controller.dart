import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeacherAddStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final nisController = TextEditingController();
  final classController = TextEditingController();
  final addressController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addStudent() async {
    if (!formKey.currentState!.validate()) return;

    // Data siswa
    final studentData = {
      'name': nameController.text,
      'nis': nisController.text,
      'classes': classController.text,
      'address': addressController.text,
    };

    // Data akun
    final accountData = {
      'username': usernameController.text,
      'password': passwordController.text,
      'role': 'student',
    };

    try {
      // Menambahkan ke koleksi "student"
      await firestore.collection('students').add(studentData);

      // Menambahkan ke koleksi "account"
      await firestore.collection('account').add(accountData);

      Get.snackbar(
        'Berhasil',
        'Data siswa berhasil ditambahkan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reset form
      formKey.currentState!.reset();
      nameController.clear();
      nisController.clear();
      classController.clear();
      addressController.clear();
      usernameController.clear();
      passwordController.clear();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
