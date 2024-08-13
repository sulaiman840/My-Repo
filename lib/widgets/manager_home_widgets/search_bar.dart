import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/notification_cubit.dart';
import '../../Bloc/secertary/course/course_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../core/utils/color_manager.dart';
import '../../screens/Home/search_screen.dart';
import '../../services/Secertary Services/beneficiary_service.dart';
import '../../services/Secertary Services/course_service.dart';
import '../../services/Secertary Services/trainer_services.dart';

class Search_Bar extends StatelessWidget {
  final String title;
  final Color searchIconColor;
  final Color fillColor;

  const Search_Bar({
    Key? key,
    required this.title,
    required this.searchIconColor,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  onSubmitted: (query) {
                    if (query.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a search term.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    BeneficiaryCubit(BeneficiaryService())
                                      ..searchBeneficiaries(query),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    TrainerCubit(TrainerService())
                                      ..searchTrainers(query),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CourseCubit(CourseService())
                                      ..searchCourses(query),
                              ),
                            ],
                            child: SearchScreen(),
                          ),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: searchIconColor),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: fillColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                iconSize: 25,
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              const SizedBox(width: 20),
              Container(
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(55)),
                  image: const DecorationImage(
                    image: AssetImage('images/logo18.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
