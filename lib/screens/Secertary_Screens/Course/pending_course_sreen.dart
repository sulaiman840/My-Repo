import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../Bloc/manager/pending_course_cubit.dart';
import '../../../Bloc/manager/pending_course_state.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/course_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class PendingCourseScreen extends StatefulWidget {
  const PendingCourseScreen({super.key});

  @override
  _PendingCourseScreenState createState() => _PendingCourseScreenState();
}

class _PendingCourseScreenState extends State<PendingCourseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchPendingRequests();
  }

  void _fetchPendingRequests() {
    context.read<PendingRequestCubit>().fetchPendingRequests();
  }

  void _showAddCourseDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String nameCourse = '';
    String coursePeriod = '';
    String type = '';
    String courseStatus = 'Active';
    String specialty = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: context.read<CourseCubit>(),
          child: BlocConsumer<CourseCubit, CourseState>(
            listener: (context, state) {
              if (state is CourseLoaded) {
                Navigator.of(context).pop();
                _fetchPendingRequests();
              } else if (state is CourseError) {

                print("Error With Creating New Course");
              }
            },
            builder: (context, state) {
              bool isLoading = state is CourseLoading;
              return AlertDialog(
                title: Text('Create a New Course'),
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Course Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the course name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameCourse = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Course Period'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the course period';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            coursePeriod = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Type'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the course type';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            type = value!;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: courseStatus,
                          items: ['Active', 'Inactive'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(labelText: 'Course Status'),
                          onChanged: (value) {
                            courseStatus = value!;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select the course status';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Specialty'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the specialty';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            specialty = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            description = value!;
                          },
                        ),
                      ],
                    ),
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
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Create'),
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newCourse = Course(
                          id: 0,
                          nameCourse: nameCourse,
                          coursePeriod: coursePeriod,
                          type: type,
                          courseStatus: courseStatus,
                          specialty: specialty,
                          description: description,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        context.read<CourseCubit>().addCourse(newCourse);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseLoaded) {
          _fetchPendingRequests();
        }
      },
      child: CommonScaffold(
        title: 'Pending Course Requests',
        scaffoldKey: _scaffoldKey,
        body: Column(
          children: [
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () => _showAddCourseDialog(context),
                child: Text(
                  'Create a New Course',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PendingRequestCubit, PendingRequestState>(
                  builder: (context, state) {
                    if (state is PendingRequestLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PendingRequestLoaded) {
                      return ListView.builder(
                        itemCount: state.pendingRequests.length,
                        itemBuilder: (context, index) {
                          final pendingRequest = state.pendingRequests[index];
                          final course = pendingRequest.requestPending;
                          return Card(
                            color: ColorManager.bc2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ColorManager.bc3,
                                child: Text(
                                  course.nameCourse[0],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                course.nameCourse,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Period: ${course.coursePeriod}',
                                    style: TextStyle(color: ColorManager.bc4),
                                  ),
                                  Text(
                                    'Status: ${pendingRequest.status}',
                                    style: TextStyle(color: ColorManager.bc3),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 12,
                              ),
                              onTap: () {

                              },
                            ),
                          );
                        },
                      );
                    } else if (state is PendingRequestError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
