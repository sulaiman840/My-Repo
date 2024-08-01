import 'package:flutter/material.dart';
import 'package:project2/screens/Manager_Screens/Education_Screen/Trainer_Manager_Education/trainers_education_screen.dart';
import '../../../core/utils/color_manager.dart';
import 'Beneficiaries_Education_Screen/beneficiaries_education_screen.dart';
import 'Courses_Education_Screen/courses_education_screen.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  void _navigateTo(BuildContext context, String category) {
    Widget targetScreen;
    switch (category) {
      case 'Courses':
        targetScreen = CoursesEducationScreen();
        break;
      case 'Beneficiaries':
        targetScreen = BeneficiariesEducationScreen();
        break;
      case 'Trainers':
        targetScreen = TrainersEducationScreen();
        break;
      default:
        targetScreen = CoursesEducationScreen();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Beneficiary Education',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.bc4,
          ),
        ),
        backgroundColor: ColorManager.bc1,
      ),
      body: Container(
        color: ColorManager.bc1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryCard(context, 'Courses', Icons.book, ColorManager.blue),
                SizedBox(width: 16),
                _buildCategoryCard(context, 'Beneficiaries', Icons.group, ColorManager.orange),
                SizedBox(width: 16),
                _buildCategoryCard(context, 'Trainers', Icons.person, ColorManager.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _navigateTo(context, title),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            shadowColor: color.withOpacity(0.8),
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.6), color.withOpacity(0.2)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 70, color: color),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




