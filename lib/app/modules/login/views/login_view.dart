import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:myskadika/app/modules/teacher_home/views/teacher_home_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My Skadika',
      logo: const AssetImage('lib/assets/logo.png'),
      onLogin: (_) => Future(() => null),
      onSignup: (_) => Future(() => null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TeacherHomeView(),
        ));
      },
      onRecoverPassword: (_) => Future(() => null),
      messages: LoginMessages(
        userHint: 'Username',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: '',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      theme: LoginTheme(
       primaryColor: Colors.green,
        accentColor: Colors.orangeAccent, // Warna aksen untuk tombol
        pageColorLight: Colors.white, // Warna background untuk mode terang
        pageColorDark: const Color.fromARGB(255, 213, 245, 215),
        cardTheme: CardTheme(
          color: Colors.grey[200], // Warna latar kartu
          elevation: 5,
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.green, // Warna latar belakang tombol
          splashColor: Colors.lightGreenAccent, // Warna efek splash
          highlightColor: Colors.greenAccent, // Warna efek highlight
          
          elevation: 5.0, // Tinggi bayangan tombol
        ),
      ),
    );
  }
}
