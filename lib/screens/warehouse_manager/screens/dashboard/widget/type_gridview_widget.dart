import 'package:flutter/material.dart';
import 'package:project2/screens/warehouse_manager/widget/manage_type_item_widget.dart';

import '../../categories/categories_screen.dart';

class TypeGridviewWidget extends StatelessWidget {
  const TypeGridviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:6,
                 crossAxisSpacing: 3,
                  mainAxisSpacing: 3
                 ), 
                 itemBuilder: (context,index)=> TypeItemWidget(
                                onTap: () {
                  Navigator.push(
                   context, 
                   MaterialPageRoute(
                      builder: (_)=> const CategoriesScreen()
                 )
                 );
                  },
                      ), )
        ;
  }
}