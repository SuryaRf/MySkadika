import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeacherProfileController extends GetxController {
  // Objek Rx untuk menyimpan data profil
  final name = ''.obs;
  final nip = ''.obs;
  final gender = ''.obs;
  final address = ''.obs;
  final phoneNumber = ''.obs;

  final isLoading = false.obs;

  // Fungsi untuk mengambil data profil
  Future<void> fetchProfile(String nipAccount) async {
    try {
      isLoading.value = true;

      // Ambil data dari koleksi teachers berdasarkan nip
      final querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('nip', isEqualTo: nipAccount)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Ambil dokumen pertama (karena nip harus unik)
        final teacherData = querySnapshot.docs.first.data();

        // Update data ke Rx
        name.value = teacherData['nama'] ?? '';
        nip.value = teacherData['nip'] ?? '';
        gender.value = teacherData['jk'] ?? '';
        address.value = teacherData['alamat'] ?? '';
        phoneNumber.value = teacherData['nomerhp'] ?? '';
      } else {
        Get.snackbar('Error', 'Data guru tidak ditemukan.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
