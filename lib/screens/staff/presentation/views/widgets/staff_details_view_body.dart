import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_cubit.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_state.dart';
import 'package:project2/screens/staff/presentation/views/widgets/custom_image_network.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/repos/staff_repo_impl.dart';
import '../../manger/delete_staff_cubit/delete_staff_cubit.dart';
import '../../manger/delete_staff_cubit/delete_staff_state.dart';
import '../update_staff_view.dart';
import 'custom_button.dart';
import 'custom_text_info.dart';

class StaffDetailsViewBody extends StatelessWidget {
  const StaffDetailsViewBody({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffDetailsCubit, StaffDetailsState>(
      listener: (context, state) {
        if (state is DeleteStaffFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Deleted failed")),
          );
        } else if (state is DeleteStaffSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delete staff successfully')),
          );
        } else if (state is DeleteStaffSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delete staff successfully')),
          );
        }
      },
      builder: (BuildContext context, StaffDetailsState state) {
        if (state is StaffDetailsSuccess) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 0.0,
                left: 100.0,
                right: 100.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomImageNetwork(
                        imageHeight: 160.0,
                        imageWidth: 160.0,
                        borderRadius: 90.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.staffDetails[0].name,
                            style: StyleManager.h2SemiBold(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            "Last update: ${(state.staffDetails[0].updatedAt).replaceRange(10, 27, " ")}",
                            style: StyleManager.labelMedium(),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          SelectButton(
                            textButton: "Edit",
                            icon: Icons.edit,
                            iconColor: ColorManager.bluelight,
                            textColor: ColorManager.bluelight,
                            buttonMinWidth: MediaQuery.of(context).size.width * .06,
                            borderColor: ColorManager.bluelight,
                            onPressed: (){
                              print('nav!!!!!!!!!!!!!!!!!!!');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UpdateStaffView(showStaffDetailsModel: state.staffDetails[0]),),
                              );
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          SelectButton(
                            textButton: "Delete",
                            icon: Icons.delete,
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            borderColor: Colors.red,
                            buttonMinWidth: MediaQuery.of(context).size.width * .06,
                            onPressed: () {
                              final deleteCubit = context.read<DeleteStaffCubit>();
                              deleteCubit.fetchDeleteStaff(id: state.staffDetails[0].id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "This is ",
                      style: StyleManager.body1Medium(),
                      children: <TextSpan>[
                        TextSpan(text: state.staffDetails[0].role, style: TextStyle(color: ColorManager.orangeLight)),
                        TextSpan(text: " account!"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Text(
                    "Join at: ${(state.staffDetails[0].createdAt).replaceRange(10, 27, " ")}",
                    style: StyleManager.body1Medium(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Text(
                    "Contact information:",
                    style: StyleManager.body2Medium(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  CustomTextInfo(
                    textAddress: "Email address",
                    text: state.staffDetails[0].email,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  CustomTextInfo(
                    textAddress: "Phone number",
                    text: state.staffDetails[0].number.toString(),
                  ),
                ],
              ),
            ),
          );
        } else if (state is StaffDetailsFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
