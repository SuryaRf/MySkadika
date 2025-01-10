import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Untuk penyimpanan lokal

class TeacherProfileController extends GetxController {
  final name = ''.obs;
  final nip = ''.obs;
  final gender = ''.obs;
  final address = ''.obs;
  final phoneNumber = ''.obs;

  final isLoading = false.obs;

  // Fungsi untuk mengambil data profil berdasarkan NIP dari login
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      // Ambil NIP dari GetStorage
      final storage = GetStorage();
      final nipAccount = storage.read<String>('nip') ?? '';

      if (nipAccount.isEmpty) {
        Get.snackbar('Error', 'NIP tidak ditemukan. Harap login ulang.');
        return;
      }

      // Query ke Firestore untuk mengambil data teachers
      final querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('nip', isEqualTo: nipAccount)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
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
