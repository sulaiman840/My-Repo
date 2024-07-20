import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets_manager.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    super.key,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
    this.image,
  });
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight ?? 55,
      width: imageWidth ?? 55,
      //margin: EdgeInsets.only(top: screenSize.height * .16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
        image: DecorationImage(
                    image: AssetImage(AssetsManager.testImage),
                    /*NetworkImage(
                      'http://127.0.0.1:8000/api$image',
                    )*/
                  )
      ),
    );
  }
}
