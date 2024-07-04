import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    this.borderRadius,
    this.buttonColor,
    required this.textButton,
    this.textColor,
    this.textWeight,
    this.textSize,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.buttonHeight,
    this.buttonMinWidth,
    required this.onPressed,
  });
  final double? borderRadius;
  final Color? buttonColor;
  final String textButton;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textSize;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonHeight;
  final double? buttonMinWidth;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(borderRadius ?? 22.0) ),
      clipBehavior: Clip.antiAlias,
      color: buttonColor ?? ColorManager.bluelight,
      child: MaterialButton(
        onPressed: (){
          onPressed();
        },
        height: buttonHeight ?? MediaQuery.of(context).size.height * .065,
        minWidth: buttonMinWidth ?? MediaQuery.of(context).size.width * .01,
        child: Row(
          children: [
            Text(
              textButton,
              style: StyleManage.button1(
                color: textColor ?? Colors.white,
                fontWeight: textWeight ?? FontWeight.w500,
                size: textSize ?? 14.5,
              ),
            ),
            Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: iconSize ?? 23,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({
    super.key,
    this.borderRadius,
    this.borderColor,
    this.buttonColor,
    required this.textButton,
    this.textColor,
    this.textWeight,
    this.textSize,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.buttonHeight,
    this.buttonMinWidth,
    required this.onPressed,
  });
  final double? borderRadius;
  final Color? borderColor;
  final Color? buttonColor;
  final String textButton;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textSize;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonHeight;
  final double? buttonMinWidth;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? MediaQuery.of(context).size.height * .05,
      width: buttonMinWidth ?? MediaQuery.of(context).size.width * .08,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10.0))
      ),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(borderRadius ?? 10.0) ),
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    textButton,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManage.button1(
                      color: textColor ?? Colors.black,
                      fontWeight: textWeight ?? FontWeight.w500,
                      size: textSize ?? 14.5,
                    ),
                  )
              ),
              Icon(
                icon,
                color: iconColor ?? Colors.black,
                size: iconSize ?? 23,
              )
            ],
          ),
        ),
      ),
    );
  }
}

