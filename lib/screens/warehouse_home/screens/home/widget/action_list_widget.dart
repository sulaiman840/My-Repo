import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';

 List<Widget> action({required double width})=>  [
          SizedBox(
                width: width,//getWidth(context)* 0.3,
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: ColorManager.bc5),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:AppSize.s20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: ColorManager.bc1,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s10,),
              IconButton(
               style: const ButtonStyle(backgroundColor:  WidgetStatePropertyAll(ColorManager.bc1)),
                icon: const Icon(Icons.notifications, color: ColorManager.blackColor,),
                onPressed: () {},
              ),
              const SizedBox(width: AppSize.s2),
              Container(
                width: AppSize.s110,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24 ,width:1),
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(55)),
                  image: const DecorationImage(
          
                    image: AssetImage('assets/images/logo18.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
        ];
      