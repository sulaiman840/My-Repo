import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/profile/user_profile_cubit.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/color_manager.dart';

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
               style: ButtonStyle(backgroundColor:  WidgetStatePropertyAll(fillColor)),
                icon: Icon(Icons.notifications, color: Colors.black,),
                onPressed: () {},
              ),
            /*  IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  context.read<UserProfileCubit>().getUserProfile();
                  Navigator.pushNamed(context, AppRouter.profile);
                },
              ),*/
              SizedBox(width: 20),
              Container(
                width: 110,
              //  height: 80,
                height: 60,
                decoration: BoxDecoration(

                  border: Border.all(color: Colors.white24 ,width:1),
                borderRadius: BorderRadiusDirectional.all(Radius.circular(55)),

                  image: DecorationImage(

                    image: AssetImage('images/logo18.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
             /* CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('images/logo10.png'),
                backgroundColor: Colors.transparent,
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
