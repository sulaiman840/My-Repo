import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/widgets/general_widgets/common_scaffold.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../warehouse_home/home/widget/common_scaffold_wear_house.dart';
import '../../data/models/all_request_category_model.dart';
import '../../data/repos/request_repo_impl.dart';
import '../manager/accept_request_cubit/accept_request_cubit.dart';
import '../manager/reject_request_cubit/reject_request_cubit.dart';
import 'widget/request_category_details_view_body.dart';

class RequestCategoryDetailsView extends StatelessWidget {
  RequestCategoryDetailsView({Key? key, required this.allRequestCategory}) : super(key: key);

  final DataRequestCategory allRequestCategory;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: allRequestCategory.type,
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AcceptRequestCubit(
                getIt.get<RequestRepoImpl>(),
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return RejectRequestCubit(
                getIt.get<RequestRepoImpl>(),
              );
            },
          ),
        ],
        child: RequestCategoryDetailsViewBody(allRequestCategory: allRequestCategory,),),
    );
  }
}
