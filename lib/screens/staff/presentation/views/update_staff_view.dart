import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/models/show_all_staff_model.dart';
import '../../data/repos/staff_repo_impl.dart';
import '../manger/update_staff_cubit/update_staff_cubit.dart';
import 'widgets/update_staff_view_body.dart';

class UpdateStaffView extends StatelessWidget {
  UpdateStaffView({Key? key, required this.allStaff}) : super(key: key);

  final ShowAllStaffModel allStaff;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Update staff",
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return UpdateStaffCubit(
            getIt.get<StaffRepoImpl>(),
          );
        },
        child: UpdateStaffViewBody(allStaff: allStaff,),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/models/show_staff_details_model.dart';
import '../../data/repos/staff_repo_impl.dart';
import '../manger/update_staff_cubit/update_staff_cubit.dart';
import 'widgets/update_staff_view_body.dart';

class UpdateStaffView extends StatelessWidget {
  const UpdateStaffView({Key? key, required this.showStaffDetailsModel}) : super(key: key);

  final ShowStaffDetailsModel showStaffDetailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateStaffCubit(
          getIt.get<StaffRepoImpl>(),
        );
      },
      child: Scaffold(
        drawer: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Container(
            color: ColorManager.blue,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    margin: EdgeInsetsDirectional.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Youth Empowerment Project',
                          style: TextStyle(
                            color: ColorManager.bluelight,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: AssetImage('images/sy.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white.withOpacity(0.4)),
                  _buildNavItem(Icons.dashboard, 'Personal', context, (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffDetailsView(id: state.allStaff[index].id),),
                    );
                  }),
                  _buildNavItem(Icons.bar_chart, 'Security', context, (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffDetailsView(id: state.allStaff[index].id),),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        body: UpdateStaffViewBody(showStaffDetailsModel: showStaffDetailsModel,),
      ),
    );
  }
}

Widget _buildNavItem(IconData icon, String title, BuildContext context, Function onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.white, size: 30),
    title: Text(title, style: TextStyle(color: Colors.white, fontSize: 19)),
    onTap: () => onTap(),
  );
}
}
*/
