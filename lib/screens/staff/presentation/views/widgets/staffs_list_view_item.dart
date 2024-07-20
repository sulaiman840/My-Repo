import 'package:flutter/material.dart';

import '../../../../../core/utils/style_manager.dart';
import 'custom_image_network.dart';

class StaffsListViewItem extends StatelessWidget {
  const StaffsListViewItem({
    super.key,
    required this.image,
    required this.rank,
    this.nameHeight,
    this.nameWidth,
    required this.name,
    this.nameSize,
    required this.description,
    this.descriptionColor,
    this.descriptionSize,
    required this.date,
  });
  final String image;
  final String rank;
  final double? nameHeight;
  final double? nameWidth;
  final String name;
  final double? nameSize;
  final String description;
  final Color? descriptionColor;
  final double? descriptionSize;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          rank,
          style: StyleManager.body1Regular(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
        ),
        CustomImageNetwork(image: image,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.007,
        ),
        SizedBox(
          height: nameHeight ?? 70,
          width: nameWidth ?? 70,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: StyleManager.body1SemiBold(
                  size: nameSize ?? 15.5,
                ),
              ),
              Text(
                description,
                style: StyleManager.labelRegular(
                  color: descriptionColor ?? Colors.grey.shade600,
                  size: descriptionSize ?? 12.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        Text(
          date.replaceRange(10, 27, " "),
          style: StyleManager.body1Regular(),
        ),
      ],
    );
  }
}
