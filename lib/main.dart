// main.dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  await FirebaseMessagingService.initialize();
  runApp(const MyApp());
}
