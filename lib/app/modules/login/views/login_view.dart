import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myskadika/app/modules/navigation_bar/views/navigation_bar_view.dart';
import '../../navigation_bar_student/views/navigation_bar_student_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      // Ambil data pengguna dari Firestore
      final querySnapshot = await FirebaseFirestore.instance
          .collection('account')
          .where('username', isEqualTo: data.name)
          .where('password', isEqualTo: data.password)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 'Username atau password salah.';
      }

      // Ambil dokumen pengguna pertama yang ditemukan
      final userDoc = querySnapshot.docs.first;
      final role = userDoc['role']; // Ambil role dari dokumen
      final storage = GetStorage();

      if (role == 'teacher') {
        // Ambil NIP jika role adalah teacher
        final nip = userDoc['nip'];
        storage.write('identifier', nip);
        storage.write('nip', nip); // Menyimpan NIP ke GetStorage
        Get.to(() => NavigationBarView());
      } else if (role == 'student') {
        final nis = userDoc['nis'];
        if (nis != null && nis.isNotEmpty) {
          final storage = GetStorage();
          storage.write('identifier', nis);
          storage.write('nis', nis);
          print('NIS berhasil disimpan: $nis');
          Get.to(() => NavigationBarStudentView());
        } else {
          print('NIS kosong atau null');
          return 'Data NIS tidak valid di Firestore.';
        }
      } else {
        return 'Role tidak dikenali.';
      }

      return null; // Login berhasil
    } catch (e) {
      return 'Terjadi kesalahan: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My Skadika',
      logo: const AssetImage('lib/assets/logo.png'),
      onLogin: _authUser,
      onSignup: (_) => Future(() => null),
      onSubmitAnimationCompleted: () {},
      onRecoverPassword: (_) => Future(() => null),
      messages: LoginMessages(
        userHint: 'Username',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      userValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username tidak boleh kosong';
        }
        return null;
      },
      
     theme: LoginTheme(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        pageColorLight: Colors.white,
        pageColorDark: const Color.fromARGB(255, 213, 245, 215),
        cardTheme: CardTheme(
          color: Colors.grey[200],
          elevation: 5,
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.green,
          splashColor: Colors.lightGreenAccent,
          highlightColor: Colors.greenAccent,
          elevation: 5.0,
        ),
        // Mengatur tampilan input field (text box)
        inputTheme: InputDecorationTheme(
          filled: true,
          // ignore: deprecated_member_use
          fillColor: Colors.green.withOpacity(0.3), // Background hijau
          hintStyle: const TextStyle(color: Colors.black), // Hint text hitam
          labelStyle: const TextStyle(color: Colors.black), // Label text hitam
          enabledBorder: OutlineInputBorder(
            // ignore: deprecated_member_use
            borderSide:  BorderSide(color: Colors.green.withOpacity(0.3)), // Border hijau
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black), // Border hitam saat fokus
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            // ignore: deprecated_member_use
            borderSide:  BorderSide(color: Colors.green.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
      hideForgotPasswordButton: true,
    );
  }
}
