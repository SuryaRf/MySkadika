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

      // Debug: Log NIP yang dibaca
      print('NIP dari GetStorage: $nipAccount');

      // Query ke Firestore untuk mengambil data teachers
      final querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('nip', isEqualTo: nipAccount)
          .get();

      // Debug: Log hasil query
      print('Hasil query Firestore: ${querySnapshot.docs}');

      if (querySnapshot.docs.isNotEmpty) {
        final teacherData = querySnapshot.docs.first.data();

        // Debug: Log data yang diterima
        print('Data guru: $teacherData');

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
      print('Error: $e'); // Debug error
    } finally {
      isLoading.value = false;
    }
  }
}
