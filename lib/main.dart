import 'package:albaladiya/Home.dart';
import 'package:albaladiya/UserIdPage.dart';
import 'package:albaladiya/chatroom.dart';
import 'package:albaladiya/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'reclamation.dart'; // Importer la page de réclamation

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ReclamationApp());
}

final routes = {
  '/ChatRoom': (context) => const ChatRoom(userId: 'default', roomId: 'default'), // Add a default roomId
  '/Home': (context) => const Home(),
  '/IdPage': (context) => UserIdPage(),
  '/Login': (context) => SignIn(),
  '/Reclamation': (context) => ReclamationPage(),
};

class ReclamationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Réclamation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/Home',
      routes: routes,
    );
  }
}