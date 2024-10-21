import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/course/course_cubit.dart';
import '../../../Bloc/secertary/course/course_state.dart';
import '../../../Bloc/manager/pending_course_cubit.dart';
import '../../../Bloc/manager/pending_course_state.dart';
import '../../../core/localization/app_localizations.dart';
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
    int coursePeriod = 0;
    String type = '';
    String courseStatus = AppLocalizations.of(context).translate('active');
    String specialty = '';
    String description = '';
    String sessionDuration = '';
    String sessionsGiven = '';

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
                print(AppLocalizations.of(context).translate('error_with_creating_course'));
              }
            },
            builder: (context, state) {
              bool isLoading = state is CourseLoading;
              return AlertDialog(
                title: Text(AppLocalizations.of(context).translate('create_new_course')),
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('course_name')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_course_name');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameCourse = value!;
                          },
                        ),
                        TextFormField(
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
                            coursePeriod = int.parse(value!);
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('type')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_course_type');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            type = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('session_duration')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_session_duration');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            sessionDuration = value!;
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: courseStatus,
                          items: [AppLocalizations.of(context).translate('active'), AppLocalizations.of(context).translate('inactive')].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('course_status')),
                          onChanged: (value) {
                            courseStatus = value!;
                          },
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context).translate('please_select_course_status');
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('specialty')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_specialty');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            specialty = value!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('description')),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context).translate('please_enter_description');
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
                    child: Text(AppLocalizations.of(context).translate('cancel')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(AppLocalizations.of(context).translate('create')),
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newCourse = Course(
                          id: 0,
                          nameCourse: nameCourse,
                          coursePeriod: coursePeriod,
                          sessionDuration: sessionDuration,
                          sessionsGiven: sessionsGiven,
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
        title: AppLocalizations.of(context).translate('pending_course_requests'),
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
                  AppLocalizations.of(context).translate('create_new_course'),
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
                                    '${AppLocalizations.of(context).translate('period')}: ${course.coursePeriod}',
                                    style: TextStyle(color: ColorManager.bc4),
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context).translate('status')}: ${pendingRequest.status}',
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
                                // Handle onTap if necessary
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
