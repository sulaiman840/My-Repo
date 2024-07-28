import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import 'elevated_btn_widget.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({Key? key, required this.title, required this.hintText, required this.onPressed, this.controller}) : super(key: key);

  final String title;
  final String hintText;
  final Function onPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: StyleManager.h3Medium(color: ColorManager.blackColor),
      ),
      content: TextField(
        autofocus: true,
        decoration:InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ),
      actions: [
        elevatedbtn(
          text: 'submit',
          style: StyleManager.labelMedium(color: ColorManager.blackColor),
          onPressed:(){
            onPressed();
          },
        ),
      ],
    );
  }
}


Future openDialog({
  required BuildContext context,
  required String title,
  required String hintText,
  required Function onPressed,
  required TextEditingController? controller,
})=>showDialog(
    context: context,
    builder:(context)=> AlertDialog(
      title: Text(
        title,
        style: StyleManager.h3Medium(color: ColorManager.blackColor),
      ),
      content: TextField(
        autofocus: true,
        decoration:InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ),
      actions: [
        elevatedbtn(
          text: 'submit',
          style: StyleManager.labelMedium(color: ColorManager.blackColor),
          onPressed:(){
            onPressed();
          },
        ),
      ],
     )
  );
                 

   