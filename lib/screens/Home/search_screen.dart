import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Bloc/secertary/course/course_state.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/course/course_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_state.dart';
import '../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../Bloc/secertary/trainer/trainer_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../services/Secertary Services/beneficiary_service.dart';
import '../../services/Secertary Services/course_service.dart';
import '../../services/Secertary Services/trainer_services.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../widgets/general_widgets/common_scaffold.dart';

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
import '../../widgets/general_widgets/common_scaffold.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({required this.query, Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<String?> _userRoleFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _userRoleFuture = SharedPreferencesHelper.getUserRole();
    _performSearch(widget.query);
  }

  @override
  void didUpdateWidget(SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      _performSearch(widget.query);
    }
  }

  void _performSearch(String query) {
    context.read<BeneficiaryCubit>().searchBeneficiaries(query);
    context.read<TrainerCubit>().searchTrainers(query);
    context.read<CourseCubit>().searchCourses(query);
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
          title: AppLocalizations.of(context).translate('search'),
          body: Column(
            children: [
              SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                indicatorColor: ColorManager.bc5,
                labelColor: ColorManager.bc5,
                unselectedLabelColor: ColorManager.bc5,
                tabs: [
                  Tab(text: AppLocalizations.of(context).translate('beneficiaries')),
                  Tab(text: AppLocalizations.of(context).translate('trainers')),
                  Tab(text: AppLocalizations.of(context).translate('courses')),
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
            return Center(child: Text(AppLocalizations.of(context).translate('no_beneficiaries_found')));
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
                      context.go('/beneficiary_detail_education/${beneficiary.id}');
                    } else {
                      context.go('/beneficiary_detail/${beneficiary.id}');
                    }
                  },
                );
              },
            ),
          );
        } else if (state is BeneficiaryError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(AppLocalizations.of(context).translate('no_beneficiaries_found')));
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
            return Center(child: Text(AppLocalizations.of(context).translate('no_trainers_found')));
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
                      context.go('/trainer_detail_education/${trainer.id}');
                    } else {
                      context.go('/trainer_detail/${trainer.id}');
                    }
                  },
                );
              },
            ),
          );
        } else if (state is TrainerError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(AppLocalizations.of(context).translate('no_trainers_found')));
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
            return Center(child: Text(AppLocalizations.of(context).translate('no_courses_found')));
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
                      context.go('/course_detail_education/${course.id}');
                    } else {
                      context.go('/course_detail/${course.id}');
                    }
                  },
                );
              },
            ),
          );
        } else if (state is CourseError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(AppLocalizations.of(context).translate('no_courses_found')));
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
