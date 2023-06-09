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
    apiKey: 'AIzaSyBolIN2tzhHeHXXw864J1tiL2OVtcT2N6U',
    appId: '1:267511721144:web:a6da852d8ad0b58718584d',
    messagingSenderId: '267511721144',
    projectId: 'rest-api-crud-d39b7',
    authDomain: 'rest-api-crud-d39b7.firebaseapp.com',
    storageBucket: 'rest-api-crud-d39b7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4zUoQ2t4W9RGwqf8azRJ-GlMgfJMegSg',
    appId: '1:267511721144:android:f41e3cb6c07e946918584d',
    messagingSenderId: '267511721144',
    projectId: 'rest-api-crud-d39b7',
    storageBucket: 'rest-api-crud-d39b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCi4DVUBB3j1L8IisPfHYFHJVFoQ4tAYfc',
    appId: '1:267511721144:ios:bdd82997301ce74618584d',
    messagingSenderId: '267511721144',
    projectId: 'rest-api-crud-d39b7',
    storageBucket: 'rest-api-crud-d39b7.appspot.com',
    iosClientId: '267511721144-380scj89ckte6p5jsre57c9kl2tbcvcn.apps.googleusercontent.com',
    iosBundleId: 'com.example.restApiCrud',
  );
}
