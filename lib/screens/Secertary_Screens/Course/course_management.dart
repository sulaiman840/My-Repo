import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/screens/Secertary_Screens/Course/pending_course_sreen.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/course_model.dart';

class CourseManagementScreen extends StatefulWidget {
  const CourseManagementScreen({super.key});

  @override
  _CourseManagementScreenState createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().fetchCourses();
  }

  void _confirmDelete(BuildContext context, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('confirm_delete')),
          content: Text(AppLocalizations.of(context).translate('sure_delete_course')),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate('delete')),
              onPressed: () {
                context.read<CourseCubit>().deleteCourse(courseId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, Course course) {
    final _formKey = GlobalKey<FormState>();
    late String _nameCourse = course.nameCourse;
    late int _coursePeriod = course.coursePeriod;
    late String _sessionDuration = course.sessionDuration;
    late String _type = course.type;
    late String _courseStatus = course.courseStatus;
    late String _specialty = course.specialty;
    late String _description = course.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('update_course')),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _nameCourse,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('course_name')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_course_name');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nameCourse = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _coursePeriod.toString(),
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('course_period')),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_course_period');
                      } else if (int.tryParse(value) == null) {
                        return AppLocalizations.of(context).translate('please_enter_valid_number');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _coursePeriod = int.parse(value!);
                    },
                  ),
                  TextFormField(
                    initialValue: _type,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('type')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_course_type');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _type = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _sessionDuration,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('session_duration')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_session_duration');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _sessionDuration = value!;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _courseStatus,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('status')),
                    items: [AppLocalizations.of(context).translate('active'), AppLocalizations.of(context).translate('inactive')]
                        .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _courseStatus = value!;
                      });
                    },
                    onSaved: (value) {
                      _courseStatus = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _specialty,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('specialty')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_course_specialty');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _specialty = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _description,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('description')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context).translate('please_enter_course_description');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();  // This can remain as-is since it's just closing a dialog
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate('update')),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedCourse = Course(
                    id: course.id,
                    nameCourse: _nameCourse,
                    coursePeriod: _coursePeriod,
                    sessionDuration: _sessionDuration,
                    type: _type,
                    courseStatus: _courseStatus,
                    specialty: _specialty,
                    description: _description,
                    createdAt: course.createdAt,
                    updatedAt: DateTime.now(),
                  );

                  context.read<CourseCubit>().updateCourse(course.id, updatedCourse);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bc1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).translate('course_management'), style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        centerTitle: true,
        backgroundColor: ColorManager.bc1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.go('/pending_course');
                },
                tooltip: AppLocalizations.of(context).translate('add_course'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CourseCubit, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CourseLoaded) {
              return ListView.builder(
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  final course = state.courses[index];
                  return Card(
                    color: ColorManager.bc2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorManager.orange,
                        child: Text(
                          course.nameCourse[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(course.nameCourse, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppLocalizations.of(context).translate('period')}: ${course.coursePeriod}',
                            style: TextStyle(color: ColorManager.bc4),
                          ),
                          Text('${AppLocalizations.of(context).translate('status')}: ${course.courseStatus}', style: TextStyle(color: ColorManager.bc3)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: course.courseStatus == "Active" ? Colors.green : Colors.red,
                            size: 12,
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.edit, color: ColorManager.blue),
                            onPressed: () {
                              _showUpdateDialog(context, course);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _confirmDelete(context, course.id);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        context.go('/course_detail/${course.id}');  // Replace Navigator.push with context.push and pass the course ID in the URL
                      },
                    ),
                  );
                },
              );
            } else if (state is CourseError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
