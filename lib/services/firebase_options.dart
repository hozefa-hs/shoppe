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
    apiKey: 'AIzaSyCEfYt_vougAqiYyv5KyPPFas9IzPcTpew',
    appId: '1:538087814970:web:541b68f13309518326c203',
    messagingSenderId: '538087814970',
    projectId: 'shoppe-754be',
    authDomain: 'shoppe-754be.firebaseapp.com',
    storageBucket: 'shoppe-754be.firebasestorage.app',
    measurementId: 'G-025R4PHN4C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo0KQnRFJEDZYWZQReHkCoRjrOG7tLKpQ',
    appId: '1:538087814970:android:019b95521d80f1a326c203',
    messagingSenderId: '538087814970',
    projectId: 'shoppe-754be',
    storageBucket: 'shoppe-754be.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCr63coV8wwIeAz1aL4le_e5PKa8aYVIJg',
    appId: '1:538087814970:ios:0d7c772128e60aee26c203',
    messagingSenderId: '538087814970',
    projectId: 'shoppe-754be',
    storageBucket: 'shoppe-754be.firebasestorage.app',
    iosBundleId: 'com.example.shoppe',
  );
}
