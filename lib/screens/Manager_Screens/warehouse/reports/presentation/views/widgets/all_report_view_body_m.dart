import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import 'reports_list_view_m.dart';

class AllReportViewBodyM extends StatelessWidget {
  AllReportViewBodyM({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(
        top: AppPadding.p16,
        bottom: AppPadding.p16,
        start: AppPadding.p16,
        end: AppPadding.p16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s24,
            ),
            ReportsListViewM(),
          ],
        ),
      ),
    );
  }
}
