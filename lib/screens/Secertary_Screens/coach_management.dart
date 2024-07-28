import 'package:flutter/material.dart';

class CoachManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach Management'),
      ),
      body: Center(
        child: Text('List of coaches with add, update, and delete options.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Coach Screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
