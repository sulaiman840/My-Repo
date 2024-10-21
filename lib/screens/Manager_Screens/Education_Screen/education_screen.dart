import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/manager/education_cubit.dart';
import '../../../Bloc/manager/education_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import 'Beneficiaries_Education_Screen/beneficiaries_education_screen.dart';
import 'Courses_Education_Screen/courses_education_screen.dart';
import 'Trainer_Manager_Education/trainers_education_screen.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  void _navigateTo(BuildContext context, String category) {
    switch (category) {
      case 'Courses':
        GoRouter.of(context).go('/courses_education');
        break;
      case 'Beneficiaries':
        GoRouter.of(context).go('/beneficiaries_education');
        break;
      case 'Trainers':
        GoRouter.of(context).go('/trainers_education');
        break;
      default:
        GoRouter.of(context).go('/courses_education');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 810;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('education_dashboard'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.bc4,
            fontSize: isWideScreen ? 28 : 24,
          ),
        ),
        backgroundColor: ColorManager.bc1,
        elevation: 0,
      ),
      body: BlocBuilder<EducationCubit, EducationState>(
        builder: (context, state) {
          if (state is EducationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EducationLoaded) {
            return buildBody(
              context,
              state.rateCompletedCourses,
              state.rateCompletedBeneficiary,
              state.rateProcessingBeneficiary,
              state.averageAge,
              isWideScreen,
            );
          } else if (state is EducationError) {
            return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildBody(
      BuildContext context,
      String rateCompletedCourses,
      String rateCompletedBeneficiary,
      String rateProcessingBeneficiary,
      int averageAge,
      bool isWideScreen,
      ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMetricCards(
              rateCompletedCourses,
              rateCompletedBeneficiary,
              rateProcessingBeneficiary,
              averageAge,
              isWideScreen,
            ),
            SizedBox(height: 30),
            _buildCategoryRow(context, isWideScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCards(
      String rateCompletedCourses,
      String rateCompletedBeneficiary,
      String rateProcessingBeneficiary,
      int averageAge,
      bool isWideScreen,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fixedHeight = 150.0;

        final isLargeScreen = constraints.maxWidth > 800;
        final itemWidth = (constraints.maxWidth - (isLargeScreen ? 3 * 8 : 2 * 8)) / (isLargeScreen ? 4 : 2);

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildMetricCard(AppLocalizations.of(context).translate('completed_courses'), '$rateCompletedCourses%', Icons.school, ColorManager.blue, itemWidth, fixedHeight, Colors.white),
            _buildMetricCard(AppLocalizations.of(context).translate('completed_beneficiaries'), '$rateCompletedBeneficiary%', Icons.group, ColorManager.orange, itemWidth, fixedHeight, Colors.white),
            _buildMetricCard(AppLocalizations.of(context).translate('processing_beneficiaries'), '$rateProcessingBeneficiary%', Icons.hourglass_empty, ColorManager.blue, itemWidth, fixedHeight, Colors.white),
            _buildMetricCard(AppLocalizations.of(context).translate('processing_beneficiaries'), '$averageAge ${AppLocalizations.of(context).translate('years')}', Icons.calendar_today,ColorManager.orange, itemWidth, fixedHeight, Colors.white),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(
      String title,
      String value,
      IconData icon,
      Color backgroundColor,
      double width,
      double height,
      Color textColor,
      ) {
    return Container(
      width: width,
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
        shadowColor: backgroundColor.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [backgroundColor.withOpacity(0.9), backgroundColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 30, color: textColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCategoryRow(BuildContext context, bool isWideScreen) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 2 * 16) / (isWideScreen ? 3 : 1);
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildCategoryCard(context, 'Courses', Icons.book, ColorManager.blue, itemWidth),
            _buildCategoryCard(context, 'Beneficiaries', Icons.group, ColorManager.orange, itemWidth),
            _buildCategoryCard(context, 'Trainers', Icons.person, ColorManager.blue, itemWidth),
          ],
        );
      },
    );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      double width,
      ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _navigateTo(context, title),
        child: Container(
          width: width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            shadowColor: color.withOpacity(0.8),
            child: Container(
              height: 150,
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
                  Icon(icon, size: 50, color: color),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
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
