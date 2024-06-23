import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/color_manager.dart';
import '../../Bloc/profile/user_profile_cubit.dart';
import '../../core/utils/app_routes.dart';
import '../../screens/Manager_Screens/profile_screen.dart';

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
                color: Colors.black, // Adjust color to match your theme
              ),
              overflow: TextOverflow.ellipsis, // Ensures text does not overflow
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3, // Responsive width for the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: searchIconColor),
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners for a modern look
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: fillColor, // Slightly translucent white
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  // Handle notification icon press
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  // Navigate to ProfileScreen and fetch profile data
                  context.read<UserProfileCubit>().getUserProfile();
                  Navigator.pushNamed(context, AppRouter.profile);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
