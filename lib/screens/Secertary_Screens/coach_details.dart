import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseId;

  CourseDetailsScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Center(
        child: Text('Details for course $courseId'),
      ),
    );
  }
}
