import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

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
    log("h${image!}");
    return ImageNetwork(
      image: "http://127.0.0.1:8000/uploads/${image!}",
      // put a height and width because they are required
      height: imageHeight ?? 55,
      width: imageWidth ?? 50,
      borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
      curve: Curves.easeIn,
      fitWeb: BoxFitWeb.cover,
      onLoading: const CircularProgressIndicator(
        color: Colors.indigoAccent,
      ),
      onError: const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset({
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
      width: imageWidth ?? 50,
      //margin: EdgeInsets.only(top: screenSize.height * .16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(borderRadius ?? 35.0),
        image: const DecorationImage(
          image: AssetImage(AssetsManager.testImage),
        )
      ),
    );
  }
}
