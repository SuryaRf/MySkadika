import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentProfileController extends GetxController {
 final name = ''.obs;
  final nis = ''.obs;
  final gender = ''.obs;
  final address = ''.obs;
  final classes = ''.obs;
  final phoneNumber = ''.obs;

  final isLoading = false.obs;

  // Fungsi untuk mengambil data profil berdasarkan NIP dari login
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      // Ambil NIP dari GetStorage
      final storage = GetStorage();
      final nisAccount = storage.read<String>('nis') ?? '';

      if (nisAccount.isEmpty) {
        Get.snackbar('Error', 'NIS tidak ditemukan. Harap login ulang.');
        return;
      }

      // Debug: Log NIP yang dibaca
      print('NIS dari GetStorage: $nisAccount');

      // Query ke Firestore untuk mengambil data teachers
      final querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('nis', isEqualTo: nisAccount)
          .get();

      // Debug: Log hasil query
      print('Hasil query Firestore: ${querySnapshot.docs}');

      if (querySnapshot.docs.isNotEmpty) {
        final studentData = querySnapshot.docs.first.data();

        // Debug: Log data yang diterima
        print('Data Siswa: $studentData');

        // Update data ke Rx
        name.value = studentData['name'] ?? '';
        nis.value = studentData['nis'] ?? '';
        gender.value = studentData['gender'] ?? '';
        address.value = studentData['address'] ?? '';
        phoneNumber.value = studentData['phone'] ?? '';
        classes.value = studentData['classes'] ?? '';
      } else {
        Get.snackbar('Error', 'Data guru tidak ditemukan.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
      print('Error: $e'); // Debug error
    } finally {
      isLoading.value = false;
    }
  }
  
  // Fungsi logout
  void logout() {
    final storage = GetStorage();
    storage.remove('nis'); // Hapus data NIP
    Get.offAllNamed('/login'); // Arahkan ke halaman login
  }
}

