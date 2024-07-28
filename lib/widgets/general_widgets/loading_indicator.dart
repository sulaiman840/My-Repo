import 'package:flutter/material.dart';
import '../../../core/utils/color_manager.dart';

class FullscreenLoadingIndicator extends StatelessWidget {
  const FullscreenLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorManager.bc0),
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}
