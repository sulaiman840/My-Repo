import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../category_warehouse/presentation/views/all_category_view.dart';
import '../../manager/delete_type_cubit/delete_type_cubit.dart';
import '../../manager/delete_type_cubit/delete_type_state.dart';
import '../../manager/get_all_type_cubit/get_all_type_cubit.dart';
import '../../manager/get_all_type_cubit/get_all_type_state.dart';
import 'type_grid_view_item.dart';

class TypeGridView extends StatelessWidget {
  const TypeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllTypeCubit, GetAllTypeState>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        if (state is GetAllTypeSuccess) {
          return BlocConsumer<DeleteTypeCubit, DeleteTypeState>(
            listener: (contextInner, stateInner) {
              if (stateInner is DeleteTypeFailure) {
                ScaffoldMessenger.of(contextInner).showSnackBar(
                  const SnackBar(content: Text("Type deleted failed")),
                );
              } else if (stateInner is DeleteTypeSuccess) {
                contextInner.read<GetAllTypeCubit>().fetchAllTypes();
                ScaffoldMessenger.of(contextInner).showSnackBar(
                  const SnackBar(content: Text('Type deleted successfully')),
                );
              }
            },
            builder: (contextInner, stateInner) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allTypes.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:6,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 6,
                ),
                itemBuilder: (context,index)=> TypeGridViewItem(
                  allTypeModel: state.allTypes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=> AllCategoryView(typeId: state.allTypes[index].id,),
                      ),
                    );
                  },
                ),
              );
            },
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