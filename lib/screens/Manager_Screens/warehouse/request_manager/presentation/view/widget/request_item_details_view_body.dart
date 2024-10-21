import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../widgets/custom_snack_bar.dart';
import '../../../data/models/all_request_item_model.dart';
import '../../manager/accept_request_cubit/accept_request_cubit.dart';
import '../../manager/accept_request_cubit/accept_request_state.dart';
import '../../manager/reject_request_cubit/reject_request_cubit.dart';
import '../../manager/reject_request_cubit/reject_request_state.dart';
import '../../manager/request_items_cubit/request_items_cubit.dart';

class RequestItemDetailsViewBody extends StatelessWidget {
  RequestItemDetailsViewBody({Key? key, required this.allRequestItem}) : super(key: key);

  final DataRequestItem allRequestItem;

  @override
  Widget build(BuildContext context) {
    AcceptRequestCubit cubit = AcceptRequestCubit.get(context);
    RejectRequestCubit cubitReject = RejectRequestCubit.get(context);
    return BlocConsumer<AcceptRequestCubit, AcceptRequestState>(
      listener: (context, state) {
        if (state is AcceptRequestSuccess) {
          context.read<RequestItemsCubit>().fetchRequestItems();
          context.go('/manager_home?tab=3');
          //Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('accept_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('accept_successfully'))),
          );*/
        } else if (state is AcceptRequestFailure) {
          context.read<RequestItemsCubit>().fetchRequestItems();
          context.go('/manager_home?tab=3');
          // Navigator.pop(context);
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
              contextReject.read<RequestItemsCubit>().fetchRequestItems();
              context.go('/manager_home?tab=3');
              //Navigator.pop(context);
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('reject_successfully'),);
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('reject_successfully'))),
              );*/
            } else if (stateReject is RejectRequestFailure) {
              contextReject.read<RequestItemsCubit>().fetchRequestItems();
              context.go('/manager_home?tab=3');
              //Navigator.pop(context);
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
                            cubit.fetchAcceptRequest(id: allRequestItem.id);
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
                            cubitReject.fetchRejectRequest(id: allRequestItem.id);
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
                          height: 400.0,
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
                                            getName(allRequestItem.requsetPending),
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
                                allRequestItem.requsetPending.contains("expired_date") ? const Spacer()
                                    : const SizedBox(height: 0, width: 0),
                                allRequestItem.requsetPending.contains("expired_date") ? Row(
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
                                            AppLocalizations.of(context).translate('expired_date'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            getExpiredDate(allRequestItem.requsetPending),
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
                                )
                                    : const SizedBox(height: 0, width: 0,),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag_outlined,
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
                                            AppLocalizations.of(context).translate('quantity'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            getQuantity(allRequestItem.requsetPending),
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
                                allRequestItem.requsetPending.contains("minimum_quantity") ? const Spacer()
                                    : const SizedBox(height: 0, width: 0),
                                allRequestItem.requsetPending.contains("minimum_quantity") ? Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.warning_amber,
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
                                            AppLocalizations.of(context).translate('minimum_quantity'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            getMinQuantity(allRequestItem.requsetPending),
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
                                )
                                    : const SizedBox(height: 0, width: 0,),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.description,
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
                                            AppLocalizations.of(context).translate('description'),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            getDescription(allRequestItem.requsetPending),
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
                                            allRequestItem.status,
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
  int y = -1;
  int j = -1;
  int k = -1;
  int f = -1;
  int g = -1;
  String getName(String list){
    String name1 = "";
    int i = 0;
    for(i = 9; i < list.length ; i++){
      if(allRequestItem.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
    }
    j = i;
    log("j  $j");
    log("Name  $name1");
    return name1;
  }
  String getExpiredDate(String list){
    log("j initial $j");
    String name1 = "";
    int i = 0;
    for(i = j+18; i < list.length ; i++){
      if(allRequestItem.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
    }
    k = i;
    log("j end $j");
    log("ExpiredDate  $name1");
    return name1;
  }
  String getQuantity(String list){
    log("j quantity $j");
    log("k initial $k");
    String name1 = "";
    int i = 0;
    for(i = k == -1 ? j+14 : k+13; i < list.length ; i++){
      if(allRequestItem.requsetPending[i] == ',') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
    }
    f = i;
    log("k end $k");
    return name1;
  }
  String getMinQuantity(String list){
    log("f initial $f");
    String name1 = "";
    int i = 0;
    for(i = f+20; i < list.length ; i++){
      if(allRequestItem.requsetPending[i] == ',') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
    }
    g = i;
    log("f end $f");
    return name1;
  }
  String getDescription(String list){
    log("f description $f");
    log("g initial $g");
    String name1 = "";
    int i = 0;
    for(i = g == -1 ? f + 16 : g + 16; i < list.length ; i++){
      if(allRequestItem.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
    }
    log("g end $g");
    return name1;
  }
}
