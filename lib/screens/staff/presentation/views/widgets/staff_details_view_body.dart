import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_cubit.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_state.dart';
import 'package:project2/screens/staff/presentation/views/widgets/custom_image_network.dart';

import 'custom_text_info.dart';

class StaffDetailsViewBody extends StatelessWidget {
  const StaffDetailsViewBody({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffDetailsCubit, StaffDetailsState>(
      listener: (context, state) {},
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
                        TextSpan(text: state.staffDetails[0].role, style: const TextStyle(color: ColorManager.orangeLight)),
                        const TextSpan(text: " account!"),
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
