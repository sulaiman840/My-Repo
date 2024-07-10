import 'package:flutter/material.dart';

class CustomConstrainedbWidget extends StatelessWidget {
   CustomConstrainedbWidget({super.key, required this.widget, required this.mediaWidth});

Widget widget;
double mediaWidth;
  @override
  Widget build(BuildContext context) {
    return  ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.width/mediaWidth),
                  child: widget );
  }
}