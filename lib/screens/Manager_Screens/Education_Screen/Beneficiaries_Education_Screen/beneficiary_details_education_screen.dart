import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Bloc/secertary/course/course_cubit.dart';
import '../../../../Bloc/secertary/course/course_state.dart';
import '../../../../Bloc/secertary/student/beneficiary_course_cubit.dart';
import '../../../../Bloc/secertary/student/beneficiary_course_state.dart';
import '../../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../../Bloc/secertary/student/document_cubit.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../../../../models/Secertary Model/beneficiary_course_model.dart';
import '../../../../models/Secertary Model/beneficiary_model.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../widgets/secretary_widgets/details_beneficiary_widgets/beneficiary_details.dart';
import '../../../../widgets/secretary_widgets/details_beneficiary_widgets/document_manager.dart';
import '../../../../widgets/secretary_widgets/details_beneficiary_widgets/document_section.dart';


class BeneficiaryDetailsEducationScreen extends StatefulWidget {
  final int beneficiaryId;

  BeneficiaryDetailsEducationScreen({required this.beneficiaryId});

  @override
  _BeneficiaryDetailsEducationScreenState createState() =>
      _BeneficiaryDetailsEducationScreenState();
}

class _BeneficiaryDetailsEducationScreenState extends State<BeneficiaryDetailsEducationScreen> {
  late Future<String?> _userRoleFuture;

  @override
  void initState() {
    super.initState();
    _userRoleFuture = SharedPreferencesHelper.getUserRole();
    _fetchData();
  }

  void _fetchData() {
    context.read<BeneficiaryCubit>().fetchBeneficiaryDetails(widget.beneficiaryId);
    context.read<DocumentCubit>().fetchDocuments(widget.beneficiaryId);
    context.read<CourseCubit>().fetchCourses();
    context.read<BeneficiaryCourseCubit>().fetchBeneficiaryCourses(widget.beneficiaryId);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Beneficiary Details',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: FutureBuilder<String?>(
        future: _userRoleFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final userRole = snapshot.data;
          return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
            builder: (context, state) {
              if (state is BeneficiaryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BeneficiaryDetailsLoaded) {
                final beneficiary = state.beneficiary;
                return BlocBuilder<BeneficiaryCourseCubit, BeneficiaryCourseState>(
                  builder: (context, courseState) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          BeneficiaryDetails(beneficiary: beneficiary),
                          if (userRole == 'secretary')
                            DocumentSection(
                              beneficiaryId: widget.beneficiaryId,
                              onDocumentsUpdated: _fetchData,
                            ),
                          if (userRole == 'manager')
                            DocumentManagerSection(
                              beneficiaryId: widget.beneficiaryId,
                              onDocumentsUpdated: _fetchData,
                            ),
                          if (courseState is BeneficiaryCourseLoaded && courseState.courses.isNotEmpty)
                            ...courseState.courses.map((course) {
                              return _buildCourseDetailCard(course);
                            }).toList(),

                        ],
                      ),
                    );
                  },
                );
              } else if (state is BeneficiaryError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('Unknown error'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCourseDetailCard(BeneficiaryCourse course) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registered Course',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDetailItem(Icons.book, 'Course Name', course.course.nameCourse),
         //   _buildDetailItem(Icons.schedule, 'Course Period', course.course.coursePeriod),
            _buildDetailItem(Icons.access_time, 'Status', course.status),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorManager.blue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
