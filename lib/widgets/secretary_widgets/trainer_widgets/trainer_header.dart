import 'package:flutter/cupertino.dart';

import '../../../../core/utils/color_manager.dart';

class TrainerHeader extends StatelessWidget {
  const TrainerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: ColorManager.bc2,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
              child: Text('ID',
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
          Expanded(
              flex: 3,
              child: Text('Name',
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
          Expanded(
              flex: 4,
              child: Text('Email',
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
          Expanded(
              flex: 4,
              child: Text('Phone',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
        ],
      ),
    );
  }
}
