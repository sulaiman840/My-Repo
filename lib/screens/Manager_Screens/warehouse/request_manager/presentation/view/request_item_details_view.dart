import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/widgets/general_widgets/common_scaffold.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../warehouse_home/home/widget/common_scaffold_wear_house.dart';
import '../../data/models/all_request_item_model.dart';
import '../../data/repos/request_repo_impl.dart';
import '../manager/accept_request_cubit/accept_request_cubit.dart';
import '../manager/reject_request_cubit/reject_request_cubit.dart';
import 'widget/request_item_details_view_body.dart';

class RequestItemDetailsView extends StatelessWidget {
  RequestItemDetailsView({Key? key, required this.allRequestItem}) : super(key: key);

  final DataRequestItem allRequestItem;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: allRequestItem.type,
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
        child: RequestItemDetailsViewBody(allRequestItem: allRequestItem,),),
    );
  }
}
