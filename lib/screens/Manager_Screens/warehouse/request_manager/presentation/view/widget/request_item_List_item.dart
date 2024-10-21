import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../data/models/all_request_item_model.dart';

class RequestItemListItem extends StatelessWidget {
  RequestItemListItem({Key? key, required this.allRequestItem}) : super(key: key);

  final DataRequestItem allRequestItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s16, horizontal: AppSize.s8),
      child: Material(
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0)),
        color: Colors.white,
        elevation: 10.0,
        child: SizedBox(
          height: 90.0,
          width: MediaQuery.of(context).size.width * .01,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s10, horizontal: AppSize.s18),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.feed,
                  color: ColorManager.blue,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getName(allRequestItem.requsetPending),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      allRequestItem.requsetPending.contains("expired_date") ? Text(
                        "${AppLocalizations.of(context).translate('expired_date')}: ${getExpiredDate(allRequestItem.requsetPending)}",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0
                        ),
                      )
                          : const SizedBox(height: 0, width: 0),
                      Text(
                        "${AppLocalizations.of(context).translate('status')} ${allRequestItem.status}",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
  int j = -1;
  String getName(String list){
    String name = '';/*allRequestCategory.requsetPending[9] + allRequestCategory.requsetPending[10] + allRequestCategory.requsetPending[11] +
        allRequestCategory.requsetPending[12] +
        allRequestCategory.requsetPending[13] + allRequestCategory.requsetPending[14] + allRequestCategory.requsetPending[15] + allRequestCategory.requsetPending[16];*/
    String name1 = "";
    int i = 0;
    for(i = 9; i < list.length /*list[i] == '"'*/ ; i++){
      if(allRequestItem.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
      log("$name1**********");
    }
    j=i;
    log(i.toString());
    log("$name1----------");
    log(name);
    return name1;
  }
  String getExpiredDate(String list){
    String name1 = "";
    int i = 0;
    for(i = j+18; i < list.length /*list[i] == '"'*/ ; i++){
      if(allRequestItem.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestItem.requsetPending[i];
      //log("$name1**********");
    }
    //log(i.toString());
    //log("$name1----------");
    //log(name);
    return name1;
  }
}
