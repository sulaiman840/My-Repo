import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/color_manager.dart';


import '../../Bloc/profile/user_profile_cubit.dart';
import '../../models/user_profile.dart';
import '../../widgets/manager_home_widgets/custom_app_bar.dart';
import '../../widgets/manager_home_widgets/main_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 600;
    bool isShortScreen = screenHeight < 145;

    return Scaffold(
      key: _scaffoldKey,
      appBar: isMobile ? CustomAppBar(scaffoldKey: _scaffoldKey) : null,
      drawer: isMobile ? MainNavBar() : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 200,
              color: ColorManager.bc5,
              child: MainNavBar(),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile && !isShortScreen)
                  Container(
                    color: ColorManager.bc0,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.bluelight,
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                Expanded(
                  child: Container(
                    color: ColorManager.bc1,
                    child: BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is UserProfileLoaded) {
                          final profile = state.userProfile;
                          return ProfileDetails(profile: profile);
                        } else if (state is UserProfileError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(child: Text('Press the profile icon to load the profile'));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final UserProfile profile;

  ProfileDetails({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(imagePath: profile.imagePath),
              SizedBox(height: 20),
              ProfileName(name: profile.name),
              SizedBox(height: 10),
              ProfileInfoCard(profile: profile),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imagePath;

  ProfileImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: imagePath != null
          ? NetworkImage(imagePath!)
          : AssetImage('images/unknown.png') as ImageProvider,
      backgroundColor: Colors.grey[200],
    );
  }
}

class ProfileName extends StatelessWidget {
  final String name;

  ProfileName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorManager.bluelight,
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final UserProfile profile;

  ProfileInfoCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileInfoRow(icon: Icons.email, label: 'Email', value: profile.email),
            Divider(),
            ProfileInfoRow(icon: Icons.person, label: 'Role', value: profile.type),
            Divider(),
            ProfileInfoRow(icon: Icons.phone, label: 'Number', value: profile.number.toString()),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileInfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
