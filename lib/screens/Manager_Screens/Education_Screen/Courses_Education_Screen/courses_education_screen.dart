import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/secertary/course/course_cubit.dart';
import '../../../../Bloc/secertary/course/course_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../Secertary_Screens/Course/course_detail_screen.dart';
import 'course_detail_education.dart';


class CoursesEducationScreen extends StatefulWidget {
  const CoursesEducationScreen({super.key});

  @override
  _CoursesEducationScreenState createState() => _CoursesEducationScreenState();
}

class _CoursesEducationScreenState extends State<CoursesEducationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Course Education',
      scaffoldKey: GlobalKey<ScaffoldState>(),
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
                          Text('Period: ${course.coursePeriod}', style: TextStyle(color: ColorManager.bc4)),
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
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailEducation(courseId: course.id)));
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
