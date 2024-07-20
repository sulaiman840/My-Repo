import 'package:flutter/cupertino.dart';
import '../../../core/utils/color_manager.dart';

class ManagerSectionWidgetSection<T> extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<T> items;
  final Widget Function(List<T>) builder;

  ManagerSectionWidgetSection(
      {required this.icon,
        required this.title,
        required this.items,
        required this.builder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Icon(icon, color: ColorManager.blue, size: 24),
            SizedBox(width: 8),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bc5)),
          ],
        ),
        SizedBox(height: 8),
        builder(items),
      ],
    );
  }
}
