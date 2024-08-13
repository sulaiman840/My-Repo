import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/secertary/course/course_cubit.dart';
import '../../../../Bloc/secertary/course/course_state.dart';
import '../../../../Bloc/secertary/trainer/trainer_course_cubit.dart';
import '../../../../Bloc/secertary/trainer/trainer_course_state.dart';
import '../../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../models/Secertary Model/trainer_course _model.dart';
import '../../../../models/Secertary Model/trainer_model.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';


class TrainerDetailsEducationScreen extends StatefulWidget {
  final int trainerId;

  const TrainerDetailsEducationScreen({required this.trainerId, Key? key}) : super(key: key);

  @override
  _TrainerDetailsEducationScreenState createState() => _TrainerDetailsEducationScreenState();
}

class _TrainerDetailsEducationScreenState extends State<TrainerDetailsEducationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<TrainerCubit>().fetchTrainerDetail(widget.trainerId);
    context.read<CourseCubit>().fetchCourses();
    context.read<TrainerCourseCubit>().fetchTrainerCourseDetail(widget.trainerId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerCubit, TrainerState>(
      listener: (context, state) {
        if (state is TrainerRegisteredInCourse) {
          context.read<TrainerCubit>().fetchTrainerDetail(widget.trainerId);
          context.read<TrainerCourseCubit>().fetchTrainerCourseDetail(widget.trainerId);
        }
      },
      child: BlocBuilder<TrainerCubit, TrainerState>(
        builder: (context, trainerState) {
          return BlocBuilder<TrainerCourseCubit, TrainerCourseState>(
            builder: (context, trainerCourseState) {
              if (trainerState is TrainerLoading || trainerCourseState is TrainerCourseLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (trainerState is TrainerDetailLoaded) {
                final trainer = trainerState.trainer;
                return CommonScaffold(
                  title: 'Trainer Detail',
                  scaffoldKey: _scaffoldKey,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailItem(Icons.person, 'Name', trainer.name ?? ''),
                                _buildDetailItem(Icons.email, 'Email', trainer.email ?? ''),
                                _buildDetailItem(Icons.phone, 'Phone', trainer.phone ?? ''),
                                _buildDetailItem(Icons.home, 'Address', trainer.address ?? ''),
                                _buildDetailItem(Icons.star, 'Specialty', trainer.specialty ?? ''),
                                _buildDetailItem(Icons.description, 'Description', trainer.description ?? ''),
                              ],
                            ),
                          ),
                        ),
                        if (trainerCourseState is TrainerCourseLoaded && trainerCourseState.trainerCourses.isNotEmpty)
                          ...trainerCourseState.trainerCourses.map((trainerCourse) {
                            return _buildCourseDetailCard(trainerCourse);
                          }).toList(),
                      ],
                    ),
                  ),
                );
              } else if (trainerState is TrainerError) {
                return Center(child: Text(trainerState.message));
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCourseDetailCard(TrainerCourse trainerCourse) {
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
            _buildDetailItem(Icons.book, 'Course Name', trainerCourse.course.nameCourse),
       //     _buildDetailItem(Icons.schedule, 'Course Period', trainerCourse.course.coursePeriod),
            _buildDetailItem(Icons.access_time, 'Count Hours', trainerCourse.countHours.toString()),
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
