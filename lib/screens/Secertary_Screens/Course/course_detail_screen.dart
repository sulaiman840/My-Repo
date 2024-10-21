import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import '../../../Bloc/secertary/course/course_detail_cubit.dart';
import '../../../Bloc/secertary/course/course_detail_state.dart';
import '../../../Bloc/secertary/student/beneficiary_course_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_course_state.dart';
import '../../../Bloc/secertary/trainer/trainer_course_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_course_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import 'package:go_router/go_router.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({required this.courseId, Key? key}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;
  final GlobalKey _beneficiaryListKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  void _fetchData() {
    context.read<CourseDetailCubit>().fetchCourseDetail(widget.courseId);
    context.read<BeneficiaryCourseCubit>().fetchBeneficiariesByCourse(widget.courseId);
    context.read<TrainerCourseCubit>().fetchTrainersByCourse(widget.courseId);
  }

  void _checkInBeneficiary(int beneficiaryId, int courseId) {
    context.read<BeneficiaryCourseCubit>().checkInBeneficiary(beneficiaryId, courseId);
  }

  void _checkInTrainer(int trainerId, int courseId) {
    context.read<TrainerCourseCubit>().checkInTrainer(trainerId, courseId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        if (state is CourseDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CourseDetailLoaded) {
          final course = state.course;
          return CommonScaffold(
            title: AppLocalizations.of(context).translate('course_detail'),
            scaffoldKey: GlobalKey<ScaffoldState>(),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailItem(Icons.book, AppLocalizations.of(context).translate('course_name'), course.nameCourse ?? 'N/A'),
                            _buildDetailItem(Icons.schedule, AppLocalizations.of(context).translate('period'), course.coursePeriod.toString()),
                            _buildDetailItem(Icons.category, AppLocalizations.of(context).translate('type'), course.type ?? 'N/A'),
                            _buildDetailItem(Icons.timeline, AppLocalizations.of(context).translate('session_duration'), course.sessionDuration ?? 'N/A'),
                            _buildDetailItem(Icons.timer, AppLocalizations.of(context).translate('sessions_given'), course.sessionsGiven.toString()),
                            _buildDetailItem(Icons.info_outline, AppLocalizations.of(context).translate('status'), course.courseStatus ?? 'N/A'),
                            _buildDetailItem(Icons.star, AppLocalizations.of(context).translate('specialty'), course.specialty ?? 'N/A'),
                            _buildDetailItem(Icons.description, AppLocalizations.of(context).translate('description'), course.description ?? 'N/A'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TabBar(
                      indicatorColor: ColorManager.bc4,
                      labelColor: ColorManager.bc4,
                      unselectedLabelColor: ColorManager.bc5,
                      controller: _tabController,
                      tabs: [
                        Tab(text: AppLocalizations.of(context).translate('beneficiaries')),
                        Tab(text: AppLocalizations.of(context).translate('trainers')),
                      ],
                    ),
                  ]),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildBeneficiariesTab(),
                  _buildTrainersTab(),
                ],
              ),
            ),
          );
        } else if (state is CourseDetailError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBeneficiariesTab() {
    return BlocBuilder<BeneficiaryCourseCubit, BeneficiaryCourseState>(
      builder: (context, state) {
        if (state is BeneficiaryCourseLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BeneficiaryCheckedIn) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(10),
              ),
            );


            context.read<BeneficiaryCourseCubit>().fetchBeneficiariesByCourse(widget.courseId);
          });
          return Container();
        } else if (state is BeneficiaryByCourseLoaded) {
          if (state.beneficiary.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).translate('no_beneficiaries_registered_in_course')));
          }
          return ListView.builder(
            key: _beneficiaryListKey,
            padding: EdgeInsets.all(8),
            itemCount: state.beneficiary.length,
            itemBuilder: (context, index) {
              final beneficiaryCourse = state.beneficiary[index];
              final beneficiary = beneficiaryCourse.beneficiary;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: ColorManager.blue, size: 30),
                  title: Text(beneficiary?.name ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('${AppLocalizations.of(context).translate('email')}: ${beneficiary?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('${AppLocalizations.of(context).translate('phone')}: ${beneficiaryCourse.beneficiary.phone}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _checkInBeneficiary(beneficiary.id!, widget.courseId),
                    child: Text(AppLocalizations.of(context).translate('check_in'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorManager.blue,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: TextStyle(letterSpacing: 1.2),
                      elevation: 8,
                      shadowColor: ColorManager.blue.withOpacity(0.5),
                    ),
                  ),
                  onTap: (){
                     context.go('/beneficiary_detail_education/${beneficiary.id}');
                    _fetchData();
                  },
                ),
              );
            },
          );
        } else if (state is BeneficiaryCourseError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildTrainersTab() {
    return BlocBuilder<TrainerCourseCubit, TrainerCourseState>(
      builder: (context, state) {
        if (state is TrainerCourseLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TrainerCheckedIn) {

          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(child: Text(state.message)),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(10),
              ),
            );


            context.read<CourseDetailCubit>().fetchCourseDetail(widget.courseId);
            context.read<TrainerCourseCubit>().fetchTrainersByCourse(widget.courseId);
          });
          return Container();
        } else if (state is TrainerByCourseLoaded) {
          if (state.trainerCourses.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context).translate('no_trainers_assigned_to_course')));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: state.trainerCourses.length,
            itemBuilder: (context, index) {
              final trainerCourse = state.trainerCourses[index];
              final trainer = trainerCourse.trainer;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: ColorManager.blue, size: 30),
                  title: Text(trainer?.name ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('${AppLocalizations.of(context).translate('email')}: ${trainer?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('${trainerCourse.countHours} ${AppLocalizations.of(context).translate('hours')}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => _checkInTrainer(trainer.id!, widget.courseId),
                    child: Text(AppLocalizations.of(context).translate('check_in'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorManager.blue,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: TextStyle(letterSpacing: 1.2),
                      elevation: 8,
                      shadowColor: ColorManager.blue.withOpacity(0.5),
                    ),
                  ),
                  onTap: ()  {
                    context.go('/trainer_detail_education/${trainer.id}');
                    _fetchData();
                  },
                ),
              );
            },
          );
        } else if (state is TrainerCourseError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
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
