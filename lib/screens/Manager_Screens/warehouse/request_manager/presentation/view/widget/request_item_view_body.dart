import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../data/models/all_request_item_model.dart';
import '../../manager/request_items_cubit/request_items_cubit.dart';
import '../../manager/request_items_cubit/request_items_state.dart';
import '../request_item_details_view.dart';
import 'request_item_List_item.dart';

class RequestItemViewBody extends StatelessWidget {
  const RequestItemViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestItemsCubit, RequestItemsState>(
      builder: (context, state) {
        if(state is RequestItemsSuccess) {
          return state.allRequestItems.dataRequestItem!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
              : ListView.separated(
            itemCount: state.allRequestItems.dataRequestItem!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                DataRequestItem allRequestItems= state.allRequestItems.dataRequestItem![index];
                context.go('/RequestItemDetailsView', extra: allRequestItems);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => RequestItemDetailsView(allRequestItem: state.allRequestItems.dataRequestItem![index],),));
              },
              child: RequestItemListItem(allRequestItem: state.allRequestItems.dataRequestItem![index],),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
          );
        } else if (state is RequestItemsFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
