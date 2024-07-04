import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/bloc_ob_server.dart';

void main() {
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());

}

