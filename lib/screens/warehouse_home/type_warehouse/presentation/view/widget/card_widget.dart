import 'package:flutter/material.dart';

import '../../../../../../core/helper/size.dart';
import '../../../../../../core/localization/app_localizations.dart';
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
                AppLocalizations.of(context).translate('hi'),
                style: StyleManager.h3Bold(color: ColorManager.bc0),
              ),
              const SizedBox(
                height: AppSize.s2,
              ),
                   Text(
                '${AppLocalizations.of(context).translate('we_are')} \n${AppLocalizations.of(context).translate('our_goal')}'
                 ,  style: StyleManager.h4Medium(color: ColorManager.bc0),
          
              ),
               Text(
                 AppLocalizations.of(context).translate('lets_work'),
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