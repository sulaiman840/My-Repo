import 'package:flutter/material.dart';

import 'widgets/staffs_view_body.dart';

class StaffsView extends StatelessWidget {
  const StaffsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StaffsViewBody(),
    );
  }
}
