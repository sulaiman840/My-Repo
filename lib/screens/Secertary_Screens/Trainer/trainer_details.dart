import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../Bloc/secertary/trainer/trainer_course_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_course_state.dart';
import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/trainer_course _model.dart';

import '../../../models/Secertary Model/trainer_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class TrainerDetailsScreen extends StatefulWidget {
  final int trainerId;

  const TrainerDetailsScreen({required this.trainerId, Key? key}) : super(key: key);

  @override
  _TrainerDetailsScreenState createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchTrainerData();
  }

  void _fetchTrainerData() {
    context.read<TrainerCubit>().fetchTrainerDetail(widget.trainerId);
    context.read<CourseCubit>().fetchCourses();
    context.read<TrainerCourseCubit>().fetchTrainerCourseDetail(widget.trainerId);
  }

  void _showCourseRegistrationDialog(BuildContext context, Trainer trainer) {
    final _formKey = GlobalKey<FormState>();
    int? selectedCourseId;
    int countHours = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('register_trainer_course')),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('count_hours')),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || int.tryParse(value) == null) {
                        return AppLocalizations.of(context).translate('enter_valid_hours');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      countHours = int.parse(value!);
                    },
                  ),
                  BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      if (state is CourseLoading) {
                        return const CircularProgressIndicator();
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
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('select_course')),
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context).translate('please_select_course');
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
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate('register')),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (selectedCourseId != null) {
                    context.read<TrainerCubit>().registerTrainerInCourse(
                      trainer.id!,
                      selectedCourseId!,
                      countHours,
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

  void _deleteCourseRegistration(int trainerId, int courseId) {
    context.read<TrainerCourseCubit>().deleteTrainerCourse(trainerId, courseId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerCubit, TrainerState>(
      listener: (context, state) {
        if (state is TrainerRegisteredInCourse) {
          _fetchTrainerData();
        }
      },
      child: BlocBuilder<TrainerCubit, TrainerState>(
        builder: (context, trainerState) {
          return BlocBuilder<TrainerCourseCubit, TrainerCourseState>(
            builder: (context, trainerCourseState) {
              if (trainerState is TrainerLoading || trainerCourseState is TrainerCourseLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (trainerState is TrainerDetailLoaded) {
                final trainer = trainerState.trainer;
                return CommonScaffold(
                  title: AppLocalizations.of(context).translate('trainer_detail'),
                  scaffoldKey: _scaffoldKey,
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => _showCourseRegistrationDialog(context, trainer),
                              child: Text(AppLocalizations.of(context).translate('register_in_course'), style: TextStyle(color: ColorManager.bc0)),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ColorManager.blue)),
                            ),
                          ],
                        ),
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
                                _buildDetailItem(Icons.person, AppLocalizations.of(context).translate('name'), trainer.name ?? ''),
                                _buildDetailItem(Icons.email, AppLocalizations.of(context).translate('email'), trainer.email ?? ''),
                                _buildDetailItem(Icons.phone, AppLocalizations.of(context).translate('phone'), trainer.phone ?? ''),
                                _buildDetailItem(Icons.home, AppLocalizations.of(context).translate('address'), trainer.address ?? ''),
                                _buildDetailItem(Icons.star, AppLocalizations.of(context).translate('specialty'), trainer.specialty ?? ''),
                                _buildDetailItem(Icons.description, AppLocalizations.of(context).translate('description'), trainer.description ?? ''),
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
              AppLocalizations.of(context).translate('registered_course'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDetailItem(Icons.book, AppLocalizations.of(context).translate('course_name'), trainerCourse.course.nameCourse),
            _buildDetailItem(Icons.access_time, AppLocalizations.of(context).translate('count_hours'), trainerCourse.countHours.toString()),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () => _deleteCourseRegistration(trainerCourse.trainerId, trainerCourse.courseId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(AppLocalizations.of(context).translate('delete_from_course'), style: TextStyle(color: Colors.white)),
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, color: ColorManager.bc4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
