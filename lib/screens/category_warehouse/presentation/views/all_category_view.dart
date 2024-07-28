import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../data/repos/category_repo_impl.dart';
import '../manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'widgets/all_category_view_body.dart';

class AllCategoryView extends StatelessWidget {
  const AllCategoryView({super.key, this.typeId});

  static const String id ='CategoriesScreen';
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
      child: AllCategoryViewBody(typeId: typeId!,));
  }
}