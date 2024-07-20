import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

class CustomEditTextField extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController? controller;
  //final String lableText;
  final String hintText;
  //final String initialValue;
  final String? Function(String?)? validator;
  //final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;
  final Function? onTap;
  final bool? enabled;
  final double? suffixSize;
  final TextCapitalization? textCapitalization;

  const CustomEditTextField({
    super.key,
    this.height,
    this.width,
    this.controller,
    //required this.lableText,
    required this.hintText,
    //required this.initialValue,
    this.validator,
    //required this.keyboardType,
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
    return Container(
      /*padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        end: 20.0,
      ),*/
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        enabled: enabled,
        textAlign: TextAlign.start,
        //keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
              width: .9,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black87,
              width: .9,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          /*label: Text(
            lableText,
          ),*/
          /*labelStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.grey[500],
          ),*/
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
          contentPadding: const EdgeInsetsDirectional.only(
            start: 15.0,
            bottom: 10.0,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: suffixIcon != null ? IconButton(onPressed: (){ onPressed!();}, icon: Icon(suffixIcon, size: suffixSize ?? 25,
            color: ColorManager.blue,)) : null,),
        obscureText: obscureText!,
        //initialValue: initialValue,
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        cursorColor: ColorManager.orangeLight,
        validator: validator ??
                (value) {
              if (value?.isEmpty ?? true) {
                return 'this field must not be empty';
              }
              return null;
            },
        onTap: (){
          onTap!();
        },
      ),
    );
  }
}
