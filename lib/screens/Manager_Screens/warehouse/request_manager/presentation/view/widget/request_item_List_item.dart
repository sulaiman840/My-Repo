import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/all_request_item_model.dart';

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
                    children: [
                      Text(
                        getName(allRequestItem.requsetPending),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Expired date: ${getExpiredDate(allRequestItem.requsetPending)}",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0
                        ),
                      ),
                      Text(
                        "Status: ${allRequestItem.status}",
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
    String name = '';
    int i;
    for(i = 9; list[i] == '\\' ; i++){
      name = name + allRequestItem.requsetPending[i];
    }
    j = i;
    return name;
  }
  String getExpiredDate(String list){
    String expiredDate = '';
    for(j + 18; list[2] == '\\' ; j++){
      expiredDate = expiredDate + allRequestItem.requsetPending[j];
    }
    return expiredDate;
  }
}
