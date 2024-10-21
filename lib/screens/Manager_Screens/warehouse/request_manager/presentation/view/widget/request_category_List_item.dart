import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../data/models/all_request_category_model.dart';

class RequestCategoryListItem extends StatelessWidget {
  const RequestCategoryListItem({Key? key, required this.allRequestCategory}) : super(key: key);

  final DataRequestCategory allRequestCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s16, horizontal: AppSize.s8),
      child: Material(
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0)),
        color: Colors.grey.shade100,
        elevation: 3.0,
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getName(allRequestCategory.requsetPending),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${AppLocalizations.of(context).translate('created_at')} ${allRequestCategory.createdAt.replaceRange(10, 27, '')}",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0
                        ),
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('status')} ${allRequestCategory.status}",
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
  String getName(String list){
    String name1 = "";
    int i = 0;
    for(i = 9; i < list.length /*list[i] == '"'*/ ; i++){
      if(allRequestCategory.requsetPending[i] == '"') {
        break;
      }
      name1 = name1 + allRequestCategory.requsetPending[i];
      //log("$name1**********");
    }
    //log(i.toString());
    log("$name1----------");
    return name1;
  }
}
