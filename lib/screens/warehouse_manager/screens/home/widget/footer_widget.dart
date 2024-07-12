import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../widget/elevated_btn_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 50,
          width: double.infinity,
          color: ColorManager.blue2,
          child:elevatedbtn(
            radius: 0,
            style: StyleManager.body2SemiBold(color: ColorManager.bc0,),
            color: ColorManager.blue2,
            onPressed: (){},
            text: 'Logout',
            icon: const Icon(Icons.logout,
            color: ColorManager.bc0,),
          ),

    );
  }
}