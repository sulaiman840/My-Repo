import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../warehouse_home/widget/elevated_btn_widget.dart';
import '../../../warehouse_home/widget/circular_icon_widget.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Side by Side List')),
        body: Column(
          children: [
              elevatedbtn(
            icon: circleIconWidget(icon: Icons.add,
            backgroundColor: ColorManager.orange, color: ColorManager.bc0),
            text: 'Add New Type',
            style: StyleManager.labelMedium(color: ColorManager.bc4),
            onPressed: ()
            {
              //الربط هنا
            },
         
          ),
           
           const SizedBox(height: AppSize.s20,),
            Expanded(child: SideBySideList())
          ],
        ),
      ),
    );
  }
}

class SideBySideList extends StatefulWidget {
  @override
  _SideBySideListState createState() => _SideBySideListState();
}

class _SideBySideListState extends State<SideBySideList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ListView on the left side
        Container(
          width: 200,
          child: ListView.builder(
            itemCount: 14,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          ),
        ),
        // Display selected item on the right side
        Expanded(
          child: Center(
            child: _selectedIndex == -1
                ? Text('Select an item from the list')
                : Text('Selected Item: Item $_selectedIndex'),
          ),
        ),
      ],
    );
  }
}

/*class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/