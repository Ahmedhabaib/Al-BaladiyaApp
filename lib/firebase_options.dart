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
        return macos;
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
    apiKey: 'AIzaSyCsq7aYTSPuXo8kg3QbnfwNJ8bbhuWKeU0',
    appId: '1:1092108822444:web:eab5d634848d1c184ebc09',
    messagingSenderId: '1092108822444',
    projectId: 'albaladiya-3c839',
    authDomain: 'albaladiya-3c839.firebaseapp.com',
    storageBucket: 'albaladiya-3c839.appspot.com',
    measurementId: 'G-E38NRYNTZE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnCtMl3b2q0-BrewR5hzZQNvrm9pxFuIU',
    appId: '1:1092108822444:android:b31485d6290545f34ebc09',
    messagingSenderId: '1092108822444',
    projectId: 'albaladiya-3c839',
    storageBucket: 'albaladiya-3c839.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPobjXLEomH2GWJafk2JB89lCRr-QAPIU',
    appId: '1:1092108822444:ios:b9b289025fd33cf64ebc09',
    messagingSenderId: '1092108822444',
    projectId: 'albaladiya-3c839',
    storageBucket: 'albaladiya-3c839.appspot.com',
    iosBundleId: 'com.example.albaladiya',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPobjXLEomH2GWJafk2JB89lCRr-QAPIU',
    appId: '1:1092108822444:ios:a122358b681e68b64ebc09',
    messagingSenderId: '1092108822444',
    projectId: 'albaladiya-3c839',
    storageBucket: 'albaladiya-3c839.appspot.com',
    iosBundleId: 'com.example.albaladiya.RunnerTests',
  );
}