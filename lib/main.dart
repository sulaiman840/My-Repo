// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

import 'firebase_messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/bloc_ob_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(options: firebaseOptions);
  //await FirebaseMessagingService.initialize();
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}
