import 'package:flutter/material.dart';

class CustomTextInfo extends StatelessWidget {
  const CustomTextInfo({
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.textPadding,
    required this.textAddress,
    required this.text,
  });
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? textPadding;
  final String textAddress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .06,
      width: width ?? MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6.0)),
        border: Border.all(color: borderColor ?? Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: textPadding ?? 25.0),
        child: Row(
          children: [
            Text(
                textAddress,
            ),
            const Spacer(),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
