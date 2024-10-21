import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Bloc/secertary/course/course_cubit.dart';
import '../../../../Bloc/secertary/course/course_state.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';

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
      title: AppLocalizations.of(context).translate('course_education'),
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
                          Text('${AppLocalizations.of(context).translate('period')}: ${course.coursePeriod}', style: TextStyle(color: ColorManager.bc4)),
                          Text('${AppLocalizations.of(context).translate('status')}: ${course.courseStatus}', style: TextStyle(color: ColorManager.bc3)),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: ColorManager.bc4,
                      ),
                      onTap: () {
                        // Pass courseId in the path
                        context.go('/course_detail_education/${course.id}');
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
