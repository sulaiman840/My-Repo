import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/item_warehouse/presentation/views/all_items_view.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../staff/presentation/views/widgets/custom_edit_text_field.dart';
import '../../manager/search_item_cubit/search_item_cubit.dart';
import '../../manager/search_item_cubit/search_item_state.dart';
import 'search_list_view.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController maxQuantityController = TextEditingController(text: "40");
  final TextEditingController minQuantityController = TextEditingController(text: "0");
  final int paginate = 50;
  final int typeId;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchItemCubit, SearchItemState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            top: AppPadding.p16,
            start: AppPadding.p16,
            end: AppPadding.p16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AllItemsView(
                          typeId: typeId,
                          categoryId: categoryId,
                        ),
                        transitionDuration: Duration.zero,
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s24,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Max: "),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                            child: CustomEditTextField(
                              controller: maxQuantityController,
                              hintText: 'Quantity',
                              //validator: (value) => value!.isEmpty ? 'Required*' : null,
                              textCapitalization: TextCapitalization.words,
                              enabled: true,
                              obscureText: false,
                              onFieldSubmitted: (value) {
                                BlocProvider.of<SearchItemCubit>(context).afterIncreasePaginate = 50;
                                _onSearch(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s8,
                          ),
                          const Text("Max: "),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                            child: CustomEditTextField(
                              controller: minQuantityController,
                              hintText: 'Quantity',
                              //validator: (value) => value!.isEmpty ? 'Required*' : null,
                              textCapitalization: TextCapitalization.words,
                              enabled: true,
                              obscureText: false,
                              onFieldSubmitted: (value) {
                                BlocProvider.of<SearchItemCubit>(context).afterIncreasePaginate = 50;
                                _onSearch(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .1,
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                BlocProvider.of<SearchItemCubit>(context).afterIncreasePaginate = 50;
                                _onSearch(context);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search, color: ColorManager.bc5),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:AppSize.s20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppSize.s30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: ColorManager.bc1,
                              ),
                              controller: nameController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width / 1,
                        height: 45.0,
                      ),
                      padding:const EdgeInsetsDirectional.symmetric(
                        //vertical: AppPadding.p16,
                        horizontal: AppPadding.p16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.bc1,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Rank",
                            style: StyleManager.body1Regular(),
                          ),
                          const SizedBox(width: AppSize.s50,),
                          Center(
                            child: Text(
                              "Name",
                              style: StyleManager.body1Regular(color: ColorManager.blackColor),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Quantity",
                            style: StyleManager.body1Regular(color: ColorManager.blackColor),
                          ),
                          const SizedBox(height: AppSize.s50,),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s24,
                ),
                SearchListView(
                  name: nameController.text,
                  typeId: typeId,
                  categoryId: categoryId,
                  maxQuantity: int.tryParse(maxQuantityController.text) ?? 0,
                  minQuantity: int.tryParse(minQuantityController.text) ?? 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _onSearch(BuildContext context) {
    BlocProvider.of<SearchItemCubit>(context).fetchSearchItem(
      name: nameController.text,
      typeId: typeId,
      categoryId: categoryId,
      status: 1,
      minQuantity: int.tryParse(minQuantityController.text) ?? 0,
      maxQuantity: int.tryParse(maxQuantityController.text) ?? 0,
      paginate: paginate,
    );
  }
}
