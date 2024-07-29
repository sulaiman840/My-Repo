import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/repos/category_repo_impl.dart';
import '../manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'widgets/all_category_view_body.dart';

class AllCategoryView extends StatelessWidget {
  AllCategoryView({super.key, this.typeId});

  static const String id ='CategoriesScreen';
  final int? typeId;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "WareHouse Manager",
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return GetAllCategoryCubit(
                getIt.get<CategoryRepoImpl>(),
              )..fetchAllCategories();
            },
          ),
        ],
        child: AllCategoryViewBody(typeId: typeId!,)),
    );
  }
}