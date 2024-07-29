import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/all_request_category_model.dart';

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
                        "Created at: ${allRequestCategory.createdAt.replaceRange(10, 27, '')}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14.0
                        ),
                      ),
                      Text(
                        "Status: ${allRequestCategory.status}",
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
    String name = allRequestCategory.requsetPending[0] + allRequestCategory.requsetPending[1] + allRequestCategory.requsetPending[2] + allRequestCategory.requsetPending[3] +
        allRequestCategory.requsetPending[4] + allRequestCategory.requsetPending[5] + allRequestCategory.requsetPending[6] + allRequestCategory.requsetPending[7] +
        allRequestCategory.requsetPending[8] + allRequestCategory.requsetPending[9] + allRequestCategory.requsetPending[10] + allRequestCategory.requsetPending[11] +
        allRequestCategory.requsetPending[12] +
        allRequestCategory.requsetPending[13] + allRequestCategory.requsetPending[14] + allRequestCategory.requsetPending[15] + allRequestCategory.requsetPending[16];
    for(int i = 12; list[i] == '\\' ; i++){
      name = name + allRequestCategory.requsetPending[i];
      log(name);
    }
    log(name);
    return name;
  }
}
