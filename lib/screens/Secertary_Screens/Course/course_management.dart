import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Secertary_Screens/Course/pending_course_sreen.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/course_model.dart';
import 'course_detail_screen.dart';
import '../../../services/Secertary Services/course_service.dart';

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
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this course?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
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
    late int _coursePeriod = course.coursePeriod ;
    late String _sessionDuration = course.sessionDuration;
  //  late String _sessionsGiven = course.sessionsGiven;
    late String _type = course.type;
    late String _courseStatus = course.courseStatus;
    late String _specialty = course.specialty;
    late String _description = course.description;



    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Course"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _nameCourse,
                    decoration: InputDecoration(labelText: 'Course Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the course name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nameCourse = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _coursePeriod.toString(),
                    decoration: InputDecoration(labelText: 'Course Period'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the course period';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _coursePeriod = int.parse(value!);
                    },
                  ),
                  TextFormField(
                    initialValue: _type,
                    decoration: InputDecoration(labelText: 'Type'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the course type';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _type = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _sessionDuration,
                    decoration: InputDecoration(labelText: 'Session Duration'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Session Duration';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _sessionDuration = value!;
                    },
                  ),
                  // TextFormField(
                  //   initialValue: _sessionsGiven,
                  //   decoration: InputDecoration(labelText: 'Session Is Given'),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter the Session Is Given';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _sessionsGiven = value!;
                  //   },
                  // ),
                  DropdownButtonFormField<String>(
                    value: _courseStatus,
                    decoration: InputDecoration(labelText: 'Status'),
                    items: ['Inactive', 'Active']
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
                    decoration: InputDecoration(labelText: 'Specialty'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the course specialty';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _specialty = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: _description,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the course description';
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
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Update"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedCourse = Course(
                    id: course.id,
                    nameCourse: _nameCourse,
                    coursePeriod: _coursePeriod,
                    sessionDuration:_sessionDuration ,
              //      sessionsGiven: _sessionsGiven,
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
        title: Text('Course Management', style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PendingCourseScreen()));
                },
                tooltip: 'Add Course',
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
                         // Text('Period: ${course.sessionsGiven} Hours from ${course.coursePeriod} Hours', style: TextStyle(color: ColorManager.bc4)),
                          Text(
                            'Period: ${course.coursePeriod}',
                            style: TextStyle(color: ColorManager.bc4),
                          ),
                          Text('Status: ${course.courseStatus}', style: TextStyle(color: ColorManager.bc3)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: course.courseStatus == 'Active' ? Colors.green : Colors.red,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(courseId: course.id,)));
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
