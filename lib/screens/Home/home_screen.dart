import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen'; // Add a static id for navigation purposes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
