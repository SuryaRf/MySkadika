// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBS7lMLYQDLpp4zc_9ANBd0K88QAX_x_8A',
    appId: '1:220115528344:web:dbd1b24e8143efc0cfbeed',
    messagingSenderId: '220115528344',
    projectId: 'myskadika',
    authDomain: 'myskadika.firebaseapp.com',
    storageBucket: 'myskadika.firebasestorage.app',
    measurementId: 'G-6M3LBC6QJ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGfi1GJXZjT4dy4gcgGzYzX8BqsU1RZPM',
    appId: '1:220115528344:android:75a8685f84b6e9a0cfbeed',
    messagingSenderId: '220115528344',
    projectId: 'myskadika',
    storageBucket: 'myskadika.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpjd7e4omaLvvMZJ4HkhMBMiWSx5CtWGw',
    appId: '1:220115528344:ios:9d8b8ac598dde53dcfbeed',
    messagingSenderId: '220115528344',
    projectId: 'myskadika',
    storageBucket: 'myskadika.firebasestorage.app',
    iosBundleId: 'com.myskadika.myskadika',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpjd7e4omaLvvMZJ4HkhMBMiWSx5CtWGw',
    appId: '1:220115528344:ios:9d8b8ac598dde53dcfbeed',
    messagingSenderId: '220115528344',
    projectId: 'myskadika',
    storageBucket: 'myskadika.firebasestorage.app',
    iosBundleId: 'com.myskadika.myskadika',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBS7lMLYQDLpp4zc_9ANBd0K88QAX_x_8A',
    appId: '1:220115528344:web:0f00e735e0941d57cfbeed',
    messagingSenderId: '220115528344',
    projectId: 'myskadika',
    authDomain: 'myskadika.firebaseapp.com',
    storageBucket: 'myskadika.firebasestorage.app',
    measurementId: 'G-MWK1745VW0',
  );
}
