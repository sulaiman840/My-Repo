import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../warehouse_home/type_warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import '../../../../../../warehouse_home/type_warehouse/presentation/manager/get_all_type_cubit/get_all_type_state.dart';
import '../../../../category_manager/presentation/views/all_category_view_manager.dart';
import 'type_grid_view_item_manager.dart';

class TypeGridViewManager extends StatelessWidget {
  const TypeGridViewManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllTypeCubit, GetAllTypeState>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        if (state is GetAllTypeSuccess) {
          return state.allTypes.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.allTypes.length,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:6,
              crossAxisSpacing: 18,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (context,index)=> TypeGridViewItemManager(
              allTypeModel: state.allTypes[index],
              onTap: () {
                int typeId = state.allTypes[index].id;
                context.go('/AllCategoryViewManager/$typeId');
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> AllCategoryViewManager(typeId: state.allTypes[index].id,),
                  ),
                );*/
              },
            ),
          );
        } else if (state is GetAllTypeFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
