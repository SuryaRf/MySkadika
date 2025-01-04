import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:myskadika/app/modules/navigation_bar/views/navigation_bar_view.dart';
import '../controllers/login_controller.dart';

const users = {
  'agus': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My Skadika',
    
      logo: const AssetImage('lib/assets/logo.png'),
      onLogin: _authUser,
      onSignup: (_) => Future(() => null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NavigationBarView(),
        ));
      },
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
          return 'Username cannot be empty';
        }
        return null; // Tidak ada validasi format email
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
      ),
    
    
      hideForgotPasswordButton: true, // Menyembunyikan tombol Forgot Password
    );
  }
}
