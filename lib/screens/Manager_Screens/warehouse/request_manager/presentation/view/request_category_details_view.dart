import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/widgets/general_widgets/common_scaffold.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../warehouse_home/category_warehouse/data/models/all_request_category_model.dart';
import '../../../../../warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import '../../../../../warehouse_home/category_warehouse/presentation/manager/accept_request_cubit/accept_request_cubit.dart';
import '../../../../../warehouse_home/category_warehouse/presentation/manager/reject_request_cubit/reject_request_cubit.dart';
import 'widget/request_category_details_view_body.dart';

class RequestCategoryDetailsView extends StatelessWidget {
  RequestCategoryDetailsView({Key? key, required this.allRequestCategory}) : super(key: key);

  final DataRequestCategory allRequestCategory;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: allRequestCategory.type,
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AcceptRequestCubit(
                getIt.get<CategoryRepoImpl>(),
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return RejectRequestCubit(
                getIt.get<CategoryRepoImpl>(),
              );
            },
          ),
        ],
        child: RequestCategoryDetailsViewBody(allRequestCategory: allRequestCategory,),),
    );
  }
}
