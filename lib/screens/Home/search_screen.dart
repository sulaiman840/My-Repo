import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/secertary/course/course_state.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/course/course_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_state.dart';
import '../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../Bloc/secertary/trainer/trainer_state.dart';
import '../../services/Secertary Services/beneficiary_service.dart';
import '../../services/Secertary Services/course_service.dart';
import '../../services/Secertary Services/trainer_services.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../widgets/general_widgets/common_scaffold.dart';
import '../Manager_Screens/Education_Screen/Beneficiaries_Education_Screen/beneficiary_details_education_screen.dart';
import '../Manager_Screens/Education_Screen/Courses_Education_Screen/course_detail_education.dart';
import '../Manager_Screens/Education_Screen/Trainer_Manager_Education/trainer_details_education_screen.dart';
import '../Secertary_Screens/Student/beneficiary_details_screen.dart';
import '../Secertary_Screens/Course/course_detail_screen.dart';
import '../Secertary_Screens/Trainer/trainer_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<String?> _userRoleFuture;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _userRoleFuture = SharedPreferencesHelper.getUserRole();
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.trim();
    });

    // Trigger the search in each Bloc
    context.read<BeneficiaryCubit>().searchBeneficiaries(_searchQuery);
    context.read<TrainerCubit>().searchTrainers(_searchQuery);
    context.read<CourseCubit>().searchCourses(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _userRoleFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final userRole = snapshot.data;

        return CommonScaffold(
          scaffoldKey: GlobalKey<ScaffoldState>(),
          title: 'Search',
          body: Column(
            children: [
              SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                indicatorColor: ColorManager.bc5,
                labelColor: ColorManager.bc5,
                unselectedLabelColor: ColorManager.bc5,
                tabs: [
                  Tab(text: 'Beneficiaries'),
                  Tab(text: 'Trainers'),
                  Tab(text: 'Courses'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBeneficiaryTab(userRole!),
                    _buildTrainerTab(userRole),
                    _buildCourseTab(userRole),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBeneficiaryTab(String userRole) {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state is BeneficiaryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BeneficiaryLoaded) {
          if (state.beneficiaries.isEmpty) {
            return Center(child: Text('No beneficiaries found.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: state.beneficiaries.length,
              itemBuilder: (context, index) {
                final beneficiary = state.beneficiaries[index];
                return _buildListTile(
                  title: beneficiary.name ?? '',
                  subtitle: beneficiary.email ?? '',
                  onTap: () {
                    if (userRole == 'manager') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeneficiaryDetailsEducationScreen(
                            beneficiaryId: beneficiary.id!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeneficiaryDetailsScreen(
                            beneficiaryId: beneficiary.id!,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        } else if (state is BeneficiaryError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No beneficiaries found.'));
        }
      },
    );
  }

  Widget _buildTrainerTab(String userRole) {
    return BlocBuilder<TrainerCubit, TrainerState>(
      builder: (context, state) {
        if (state is TrainerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TrainerLoaded) {
          if (state.trainers.isEmpty) {
            return Center(child: Text('No trainers found.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: state.trainers.length,
              itemBuilder: (context, index) {
                final trainer = state.trainers[index];
                return _buildListTile(
                  title: trainer.name ?? '',
                  subtitle: trainer.specialty ?? '',
                  onTap: () {
                    if (userRole == 'manager') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainerDetailsEducationScreen(
                            trainerId: trainer.id!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrainerDetailsScreen(
                            trainerId: trainer.id!,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        } else if (state is TrainerError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No trainers found.'));
        }
      },
    );
  }

  Widget _buildCourseTab(String userRole) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CourseLoaded) {
          if (state.courses.isEmpty) {
            return Center(child: Text('No courses found.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return _buildListTile(
                  title: course.nameCourse ?? '',
                  subtitle: course.description ?? '',
                  onTap: () {
                    if (userRole == 'manager') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailEducation(
                            courseId: course.id!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailScreen(
                            courseId: course.id!,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        } else if (state is CourseError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No courses found.'));
        }
      },
    );
  }

  Widget _buildListTile({required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        title: Text(
          title,
          style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: ColorManager.bc5),
        ),
        onTap: onTap,
      ),
    );
  }
}
