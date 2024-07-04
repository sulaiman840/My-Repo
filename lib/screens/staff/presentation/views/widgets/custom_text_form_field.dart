/*
import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {

  final IconData icon;
  final TextEditingController? controller;
  //final String lableText;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;
  final Function? onTap;
  final bool? enabled;
  final double? suffixSize;
  final TextCapitalization? textCapitalization;

  const RegisterTextField({
    super.key,
    required this.icon,
    this.controller,
    //required this.lableText,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    this.onPressed,
    this.onTap,
    this.enabled,
    this.suffixSize,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomeIcon(
          icon: icon,
        ),
        Expanded(
          child: EditTextField(
            //lableText: lableText,
            enabled: enabled,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            hintText: hintText,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            suffixIcon: suffixIcon,
            obscureText: obscureText != null ? obscureText! : false,
            onPressed: (){
              onPressed!();
            },
            onTap: (){
              onTap!();
            },
            suffixSize: suffixSize,
          ),
        ),
      ],
    );
  }
}
*/
