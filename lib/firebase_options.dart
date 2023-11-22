// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC-s7UmHeg8Veas-owjCoJAokEmpbkbpog',
    appId: '1:362103461008:web:026cc9233adb1c13da3415',
    messagingSenderId: '362103461008',
    projectId: 'exovite-e1992',
    authDomain: 'exovite-e1992.firebaseapp.com',
    storageBucket: 'exovite-e1992.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfCiERNYplprw-1WeC66pfMmyCrGfjc_k',
    appId: '1:362103461008:android:97306403b8ab80ecda3415',
    messagingSenderId: '362103461008',
    projectId: 'exovite-e1992',
    storageBucket: 'exovite-e1992.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFLF5Ocxp6RBg_cdmZAtQ798jN70LlRCE',
    appId: '1:362103461008:ios:127465da84624d2bda3415',
    messagingSenderId: '362103461008',
    projectId: 'exovite-e1992',
    storageBucket: 'exovite-e1992.appspot.com',
    iosBundleId: 'com.example.exovite',
  );
}
