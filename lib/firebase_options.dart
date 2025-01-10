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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUOo0LmYGz4Ubd3hv4aNpLhb4qo1ByoHw',
    appId: '1:796660839040:android:1b5d5aa37a681e181cac65',
    messagingSenderId: '796660839040',
    projectId: 'signindemo-b41db',
    storageBucket: 'signindemo-b41db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDToQhPiOpxn3epmrYWxaVTGb7WB5_6jqc',
    appId: '1:796660839040:ios:7ae539f2434a77651cac65',
    messagingSenderId: '796660839040',
    projectId: 'signindemo-b41db',
    storageBucket: 'signindemo-b41db.firebasestorage.app',
    androidClientId: '796660839040-7amr1tngler2ib9atv090d92ovcr2eeq.apps.googleusercontent.com',
    iosClientId: '796660839040-uidu4m2lcpj7ps9ndq9o29ghn2g6bq6c.apps.googleusercontent.com',
    iosBundleId: 'com.example.tasks',
  );
}
