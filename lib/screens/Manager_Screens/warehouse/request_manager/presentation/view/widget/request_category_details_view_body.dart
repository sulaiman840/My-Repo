import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../widgets/custom_snack_bar.dart';
import '../../../data/models/all_request_category_model.dart';
import '../../manager/accept_request_cubit/accept_request_cubit.dart';
import '../../manager/accept_request_cubit/accept_request_state.dart';
import '../../manager/reject_request_cubit/reject_request_cubit.dart';
import '../../manager/reject_request_cubit/reject_request_state.dart';
import '../../manager/request_category_cubit/request_category_cubit.dart';

class RequestCategoryDetailsViewBody extends StatelessWidget {
  const RequestCategoryDetailsViewBody({Key? key, required this.allRequestCategory}) : super(key: key);

  final DataRequestCategory allRequestCategory;

  @override
  Widget build(BuildContext context) {
    AcceptRequestCubit cubit = AcceptRequestCubit.get(context);
    RejectRequestCubit cubitReject = RejectRequestCubit.get(context);
    return BlocConsumer<AcceptRequestCubit, AcceptRequestState>(
      listener: (context, state) {
        if (state is AcceptRequestSuccess) {
          context.read<RequestCategoryCubit>().fetchRequestCategories();
          context.go('/manager_home?tab=3');
          //Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('accept_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('accept_successfully'))),
          );*/
        } else if (state is AcceptRequestFailure) {
          context.read<RequestCategoryCubit>().fetchRequestCategories();
          context.go('/manager_home?tab=3');
          //Navigator.pop(context);
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('accept_failed'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('accept_failed'))),
          );*/
        }
      },
      builder: (context, state) {
        return BlocConsumer<RejectRequestCubit, RejectRequestState>(
          listener: (contextReject, stateReject) {
            if (stateReject is RejectRequestSuccess) {
              contextReject.read<RequestCategoryCubit>().fetchRequestCategories();
              context.go('/manager_home?tab=3');
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('reject_successfully'),);
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('reject_successfully'))),
              );*/
            } else if (stateReject is RejectRequestFailure) {
              contextReject.read<RequestCategoryCubit>().fetchRequestCategories();
              context.go('/manager_home?tab=3');
              Navigator.pop(context);
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('reject_failed'),);
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('reject_failed'))),
              );*/
            }
          },
          builder: (contextReject, stateReject) {
            return Padding(
              padding: const EdgeInsets.all(AppSize.s16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.fetchAcceptRequest(id: allRequestCategory.id);
                          },
                          child: Container(
                            height: 35.0,
                            width: MediaQuery.of(context).size.width * 0.08,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                              color: Colors.green,
                            ),
                            child: state is AcceptRequestLoading ? const Center(child: CircularProgressIndicator(color: ColorManager.blue,),)
                                : Center(
                              child: Text(
                                AppLocalizations.of(context).translate('approve'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSize.s16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                        GestureDetector(
                          onTap: () {
                            cubitReject.fetchRejectRequest(id: allRequestCategory.id);
                          },
                          child: Container(
                            height: 35.0,
                            width: MediaQuery.of(context).size.width * 0.08,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(Radius.circular(8.0)),
                              color: Colors.red,
                            ),
                            child: stateReject is RejectRequestLoading ? const Center(child: CircularProgressIndicator(color: ColorManager.blue,),)
                                : Center(
                              child: Text(
                                AppLocalizations.of(context).translate('reject'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSize.s16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.s16,),
                      child: Material(
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0)),
                        color: Colors.grey.shade100,
                        elevation: 2.0,
                        child: SizedBox(
                          height: 300.0,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSize.s16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.feed,
                                      color: ColorManager.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate('category_name'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            getName(allRequestCategory.requsetPending),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      color: ColorManager.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate('created_at'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            allRequestCategory.createdAt.replaceRange(10, 27, ''),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.edit_calendar_outlined,
                                      color: ColorManager.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate('last_updated'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            allRequestCategory.updatedAt.replaceRange(10, 27, ''),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: ColorManager.blue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate('request_status'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            allRequestCategory.status,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  String getName(String list){
    String name1 = "";
    int i = 0;
    for(i = 9; i < list.length /*list[i] == '"'*/ ; i++){
      if(allRequestCategory.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestCategory.requsetPending[i];
      log("$name1**********");
    }
    log(i.toString());
    log("$name1----------");
    return name1;
  }
}
