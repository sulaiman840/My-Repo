import 'package:flutter/material.dart';

import '../../../../../core/utils/style_manager.dart';
import '../create_staff_view.dart';
import 'custom_button.dart';
import 'staffs_list_view.dart';

class StaffsViewBody extends StatelessWidget {
  const StaffsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextIconButton(
              textButton: "Add Staff",
              icon: Icons.add,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateStaffView(),)
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .01,
            ),
            const Text("Sorted by: "),
            SelectButton(
              textButton: " DefaultDefaultDefaultDefaultDefaultDefault",
              icon: Icons.arrow_drop_down_sharp,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Rank",
              style: StyleManage.body1Regular(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.045,
            ),
            Text(
              "Name",
              style: StyleManage.body1Regular(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.455,
            ),
            Text(
              "Date of join",
              style: StyleManage.body1Regular(),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.001,
          child: Container(
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        const StaffsListView(),
      ],
    );
  }
}
