import 'package:flutter/material.dart';

import '../../../../../../core/helper/size.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   
      Card(
        
        color: ColorManager.orange,
        //elevation: ,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16,
          vertical: AppPadding.p4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Text(
                'Hi, your name',
                style: StyleManager.h3Bold(color: ColorManager.bc0),
              ),
              const SizedBox(
                height: AppSize.s2,
              ),
                   Text(
                'We are delighted to have you here! \nOur goal is to provide you with the best inventory management experience.'
                 ,  style: StyleManager.h4Medium(color: ColorManager.bc0),
          
              ),
               Text(
                ' Let\'s work together to enhance your operational efficiency!',
                                  style: StyleManager.h4Medium(color: ColorManager.bc0),
          
              ),
                ],
              ),
              
              Image(
                image: const AssetImage('assets/images/dashboard.png'),
                 
                 height: getWidth(context)/8,
                )
              
            ],
          ),
        ),
      )
       ;
  }
}