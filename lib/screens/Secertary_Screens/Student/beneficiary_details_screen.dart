import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../Bloc/secertary/student/document_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_course_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_course_state.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/shared_preferences_helper.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Secertary Model/beneficiary_course_model.dart';
import '../../../services/Secertary Services/beneficiary_service.dart';

import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../widgets/secretary_widgets/details_beneficiary_widgets/beneficiary_details.dart';
import '../../../widgets/secretary_widgets/details_beneficiary_widgets/document_manager.dart';
import '../../../widgets/secretary_widgets/details_beneficiary_widgets/document_section.dart';

class BeneficiaryDetailsScreen extends StatefulWidget {
  final int beneficiaryId;

  BeneficiaryDetailsScreen({required this.beneficiaryId});

  @override
  _BeneficiaryDetailsScreenState createState() =>
      _BeneficiaryDetailsScreenState();
}

class _BeneficiaryDetailsScreenState extends State<BeneficiaryDetailsScreen> {
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

  void _showCourseRegistrationDialog(BuildContext context, DataBeneficiary beneficiary) {
    final _formKey = GlobalKey<FormState>();
    int? selectedCourseId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Register Beneficiary in Course'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocBuilder<CourseCubit, CourseState>(
                  builder: (context, state) {
                    if (state is CourseLoading) {
                      return CircularProgressIndicator();
                    } else if (state is CourseLoaded) {
                      return DropdownButtonFormField<int>(
                        value: selectedCourseId,
                        items: state.courses.map((course) {
                          return DropdownMenuItem<int>(
                            value: course.id,
                            child: Text(course.nameCourse),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedCourseId = value;
                        },
                        decoration: InputDecoration(labelText: 'Select Course'),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a course';
                          }
                          return null;
                        },
                      );
                    } else if (state is CourseError) {
                      return Text(state.message);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Register'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (selectedCourseId != null) {
                    context.read<BeneficiaryCourseCubit>().addBeneficiaryToCourse(
                      widget.beneficiaryId,
                      selectedCourseId!,
                    );
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCourseRegistration(int beneficiaryId, int courseId) {
    context.read<BeneficiaryCourseCubit>().deleteBeneficiaryFromCourse(beneficiaryId, courseId);
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => _showCourseRegistrationDialog(context, beneficiary),
                                child: Text('Register in a Course',style: TextStyle(color: ColorManager.bc0),),
                                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorManager.blue)),
                              ),
                            ],
                          ),
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
            _buildDetailItem(Icons.schedule, 'Course Period', course.course.coursePeriod),
            _buildDetailItem(Icons.access_time, 'Status', course.status),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () => _deleteCourseRegistration(course.beneficiaryId, course.courseId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Delet From Course', style: TextStyle(color: Colors.white)),
              ),
            ),
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
