import 'package:flutter/material.dart';

import 'widget/all_type_view_body.dart';

class AllTypeView extends StatelessWidget {
  const AllTypeView({super.key});

  static const String id = 'DashboardScreen';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AllTypeViewBody(),
    );
  }
}
