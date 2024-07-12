import 'package:flutter/material.dart';

import '../../../../../core/helper/size.dart';
import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 230,
          width: double.infinity,
          
          color: ColorManager.blue2,
          child:  Center(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: getWidth(context)/12,
                   decoration: const BoxDecoration(
                    color: ColorManager.bc1,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                
                ),
              
                const SizedBox(height: AppSize.s26),
                 Text(
                      'Youth Empowerment Project',
                      style :StyleManager.body1Bold(color: ColorManager.bc0),
                      textAlign: TextAlign.center,
                    ),
              ],
            )
          ),
        );
  }
}