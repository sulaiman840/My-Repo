import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import '../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'widgets/all_category_view_body_manager.dart';

class AllCategoryViewManager extends StatelessWidget {
  AllCategoryViewManager({super.key, this.typeId});

  final int? typeId;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Categories",
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
          child: AllCategoryViewBodyManager(typeId: typeId!,),
      ),
    );
  }
}
