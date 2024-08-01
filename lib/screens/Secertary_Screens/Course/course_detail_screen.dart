import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/course/course_detail_cubit.dart';
import '../../../Bloc/secertary/course/course_detail_state.dart';
import '../../../Bloc/secertary/student/beneficiary_course_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_course_state.dart';
import '../../../Bloc/secertary/trainer/trainer_course_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_course_state.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import '../Student/beneficiary_details_screen.dart';
import '../Trainer/trainer_details.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({required this.courseId, Key? key}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        if (state is CourseDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CourseDetailLoaded) {
          final course = state.course;
          return CommonScaffold(
            title: 'Course Detail',
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
                            _buildDetailItem(Icons.book, 'Course Name', course.nameCourse ?? 'N/A'),
                            _buildDetailItem(Icons.schedule, 'Period', course.coursePeriod ?? 'N/A'),
                            _buildDetailItem(Icons.category, 'Type', course.type ?? 'N/A'),
                            _buildDetailItem(Icons.info_outline, 'Status', course.courseStatus ?? 'N/A'),
                            _buildDetailItem(Icons.star, 'Specialty', course.specialty ?? 'N/A'),
                            _buildDetailItem(Icons.description, 'Description', course.description ?? 'N/A'),
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
                        Tab(text: 'Beneficiaries'),
                        Tab(text: 'Trainers'),
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
        } else if (state is BeneficiaryByCourseLoaded) {
          if (state.beneficiary.isEmpty) {
            return Center(child: Text('No beneficiaries registered in this course.'));
          }
          return ListView.builder(
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
                      Text('Email: ${beneficiary?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('Phone: ${beneficiaryCourse.beneficiary.phone}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeneficiaryDetailsScreen(beneficiaryId: beneficiary.id),
                      ),
                    ).then((_) => _fetchData());
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
        } else if (state is TrainerByCourseLoaded) {
          if (state.trainerCourses.isEmpty) {
            return Center(child: Text('No trainers assigned to this course.'));
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
                      Text('Email: ${trainer?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('${trainerCourse.countHours} hours', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainerDetailsScreen(trainerId: trainer.id),
                      ),
                    ).then((_) => _fetchData());
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
