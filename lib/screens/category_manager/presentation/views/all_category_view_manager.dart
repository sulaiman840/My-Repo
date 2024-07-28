import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../category_warehouse/data/repos/category_repo_impl.dart';
import '../../../category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'widgets/all_category_view_body_manager.dart';

class AllCategoryViewManager extends StatelessWidget {
  const AllCategoryViewManager({super.key, this.typeId});

  final int? typeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return GetAllCategoryCubit(
                getIt.get<CategoryRepoImpl>(),
              )..fetchAllCategories();
            },
          ),

        ],
        child: Scaffold(
          backgroundColor: ColorManager.bc0,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: AllCategoryViewBodyManager(typeId: typeId!,),
        ),
    );
  }
}
