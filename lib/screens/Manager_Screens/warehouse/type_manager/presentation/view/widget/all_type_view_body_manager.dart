import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import 'type_grid_view_manager.dart';

class AllTypeViewBodyManager extends StatelessWidget {
   AllTypeViewBodyManager({Key? key}) : super(key: key);

  final TextEditingController typeController = TextEditingController();

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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s24,
            ),
            TypeGridViewManager(),
          ],
        ),
      ),
    );
  }
}
