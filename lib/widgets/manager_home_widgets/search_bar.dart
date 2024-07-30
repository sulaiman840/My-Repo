import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../core/utils/color_manager.dart';
import '../../screens/Home/search_screen.dart';
import '../../services/Secertary Services/beneficiary_service.dart';


class Search_Bar extends StatelessWidget {
  final String title;
  final Color searchIconColor;
  final Color fillColor;

  Search_Bar({
    required this.title,
    required this.searchIconColor,
    required this.fillColor,
  });

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
              style: TextStyle(
                fontSize: 20,
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
                      // If the query is empty, do nothing or show a message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a search term.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => BeneficiaryCubit(BeneficiaryService())..searchBeneficiaries(query),
                            child: SearchResultsScreen(query: query),
                          ),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: searchIconColor),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: fillColor,
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
              SizedBox(width: 20),
              Container(
                width: 110,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(55)),
                  image: DecorationImage(
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
