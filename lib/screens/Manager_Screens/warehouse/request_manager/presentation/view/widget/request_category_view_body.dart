import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../data/models/all_request_category_model.dart';
import '../../manager/request_category_cubit/request_category_cubit.dart';
import '../../manager/request_category_cubit/request_category_state.dart';
import '../request_category_details_view.dart';
import 'request_category_List_item.dart';

class RequestCategoryViewBody extends StatelessWidget {
  const RequestCategoryViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCategoryCubit, RequestCategoryState>(
      builder: (context, state) {
        if(state is RequestCategorySuccess) {
          return state.allRequestCategories.dataRequestCategory!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
              : ListView.separated(
            itemCount: state.allRequestCategories.dataRequestCategory!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                DataRequestCategory allRequestCategory= state.allRequestCategories.dataRequestCategory![index];
                context .go('/RequestCategoryDetailsView', extra: allRequestCategory);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => RequestCategoryDetailsView(allRequestCategory: state.allRequestCategories.dataRequestCategory![index],),));
              },
              child: RequestCategoryListItem(allRequestCategory: state.allRequestCategories.dataRequestCategory![index],),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
          );
        } else if (state is RequestCategoryFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
