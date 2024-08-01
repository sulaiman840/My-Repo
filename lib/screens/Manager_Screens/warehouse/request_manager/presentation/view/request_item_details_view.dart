import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/widgets/general_widgets/common_scaffold.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../warehouse_home/category_warehouse/data/models/all_request_item_model.dart';
import '../../../../../warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import '../../../../../warehouse_home/category_warehouse/presentation/manager/accept_request_cubit/accept_request_cubit.dart';
import '../../../../../warehouse_home/category_warehouse/presentation/manager/reject_request_cubit/reject_request_cubit.dart';
import 'widget/request_item_details_view_body.dart';

class RequestItemDetailsView extends StatelessWidget {
  RequestItemDetailsView({Key? key, required this.allRequestItem}) : super(key: key);

  final DataRequestItem allRequestItem;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: allRequestItem.type,
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
        child: RequestItemDetailsViewBody(allRequestItem: allRequestItem,),),
    );
  }
}
