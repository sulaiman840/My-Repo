import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../../manager/check_expiring_cubit/check_expiring_cubit.dart';
import '../../manager/check_expiring_cubit/check_expiring_state.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_cubit.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_state.dart';
import '../../manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../manager/import_from_excel_cubit/import_from_excel_cubit.dart';
import '../../manager/import_from_excel_cubit/import_from_excel_state.dart';
import '../create_item_view.dart';
import '../search_view.dart';
import 'item_list_view.dart';

class AllItemsBody extends StatefulWidget {
  const AllItemsBody({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;

  @override
  State<AllItemsBody> createState() => _AllItemsBodyState();
}

class _AllItemsBodyState extends State<AllItemsBody> {

  final List<String> _items = ['id','name','description','quantity','minimum_quantity','expired_date','created_at','updated_at'];
  final Map<String, bool> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    // Initialize selected items to false
    for (var item in _items) {
      _selectedItems[item] = false;
    }
  }

  void _showCheckListDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context).translate('select_fields')),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _items.map((item) {
                    return CheckboxListTile(
                      title: Text(item),
                      value: _selectedItems[item],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedItems[item] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).translate('cancel')),
                ),
                TextButton(
                  onPressed: () {
                    // استخراج الحقول المحددة
                    List<String> selectedValues = _selectedItems.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    // استخدام `read` مع سياق حديث من أجل `ExportToExcelCubit`
                    context.read<ExportToExcelCubit>().fetchExportToExcel(fields: selectedValues);

                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).translate('submit')),
                ),
              ],
            );

          },
        );
      },
    );
  }


  // Function to handle sending selected items to an API
  void _sendSelectedItems(List<String> selectedItems) {
    // For demonstration purposes, we just print the selected items.
    // Here you would send them to your API.
    print("Selected items: $selectedItems");

    // Example of how to send the data to an API:
    // API call logic goes here...
  }

  @override
  Widget build(BuildContext context) {
    ImportFromExcelCubit importCubit = ImportFromExcelCubit.get(context);
    return BlocConsumer<CheckExpiringCubit, CheckExpiringState>(
      listener: (contextCheck, stateCheck) {
        if (stateCheck is CheckExpiringSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('check_expiring_successfully'),);
        } else if (stateCheck is CheckExpiringFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('check_expiring_failed'),);
        }
      },
      builder: (contextCheck, stateCheck) {
        return BlocConsumer<ImportFromExcelCubit, ImportFromExcelState>(
          listener: (contextImport, stateImport) {
            if (stateImport is SelectedFileSuccess) {
              ImportFromExcelCubit.get(context).
              fetchImportFromExcel(
                excelFile: importCubit.selectedImage!,
              );
            }
            if (stateImport is ImportFromExcelFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('import_items_failed'),);
              /*ScaffoldMessenger.of(contextImport).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('import_items_failed'))),
              );*/
            } else if (stateImport is ImportFromExcelSuccess) {
              contextImport.read<GetAllItemsCubit>().fetchAllItems(
                paginate: 50,
              );
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('items_imported_successfully'),);
              /*ScaffoldMessenger.of(contextImport).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('items_imported_successfully'))),
              );*/
            } else if (stateImport is SelectedFileFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('file_picked_failed'),);
              /*ScaffoldMessenger.of(contextImport).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('file_picked_failed'))),
              );*/
            } else if (stateImport is SelectedFileEmpty) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('pick_file_first'),);
              /*ScaffoldMessenger.of(contextImport).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('pick_file_first'))),
              );*/
            }
          },
          builder: (contextImport, stateImport) {
            return BlocConsumer<ExportToExcelCubit, ExportToExcelState>(
              listener: (context, state) {
                if (state is ExportToExcelFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('export_items_failed'),);
                  /*ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context).translate('export_items_failed'))),
                  );*/
                } else if (state is ExcelFileSaveSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('items_exported_successfully'),);
                  /*ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context).translate('items_exported_successfully'))),
                  );*/
                }
              },
              builder: (context, state) {
                return DefaultTabController(
                  length: 3,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AppPadding.p16,
                      bottom: AppPadding.p16,
                      start: AppPadding.p16,
                      end: AppPadding.p16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Tooltip(
                                message: AppLocalizations.of(context).translate('check_expiring'),
                                child: GestureDetector(
                                  onTap: () {
                                    CheckExpiringCubit.get(context).fetchCheckExpiring();
                                  },
                                  child: circleIconWidget(
                                      icon: FontAwesomeIcons.houseCircleCheck,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      radius: 30.0,
                                      size: 25.0
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('import_items'),
                                child: GestureDetector(
                                  onTap: () {
                                    ImportFromExcelCubit.get(context).pickImage();
                                  },
                                  child: circleIconWidget(
                                      icon: FontAwesomeIcons.fileImport,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      radius: 30.0,
                                      size: 25.0
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('export_items'),
                                child: GestureDetector(
                                  onTap: () {
                                    _showCheckListDialog();
                                    //BlocProvider.of<ExportToExcelCubit>(context).fetchExportToExcel(fields: ["id","name","quantity"]);
                                  },
                                  child: circleIconWidget(
                                      icon: FontAwesomeIcons.fileExport,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      radius: 30.0,
                                      size: 25.0
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('search'),
                                child: GestureDetector(
                                  onTap: () {
                                    context.go('/SearchView/${widget.typeId}/${widget.categoryId}');
                                    /*Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => SearchView(
                                          typeId: typeId,
                                          categoryId: categoryId,
                                        ),
                                        transitionDuration: Duration.zero,
                                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                      ),
                                    );*/
                                  },
                                  child: circleIconWidget(
                                    icon: Icons.search_sharp,
                                    backgroundColor: Colors.transparent,
                                    color: ColorManager.blue,
                                    size: AppSize.s30,
                                    radius: AppSize.s20,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('add_item'),
                                child: GestureDetector(
                                  onTap: () {
                                    context.go('/CreateItemView/${widget.typeId}/${widget.categoryId}');
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateItemView(
                                        typeId: typeId,
                                        categoryId: categoryId,
                                      ),),
                                    );*/
                                  },
                                  child: circleIconWidget(
                                    icon: Icons.add_circle_outline,
                                    backgroundColor: Colors.transparent,
                                    color: ColorManager.blue,
                                    size: AppSize.s30,
                                    radius: AppSize.s20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        // Add TabBar in the AppBar
                        SizedBox(
                          height: AppSize.s50,
                          child: AppBar(
                            bottom: const TabBar(
                              indicatorColor: ColorManager.bc4,
                              labelColor: ColorManager.bc4,
                              unselectedLabelColor: ColorManager.bc5,
                              tabs: [
                                Tab(text: 'All Items'),
                                Tab(text: 'Expiring Items'),
                                Tab(text: 'Expired Items'),
                              ],
                            ),
                          ),
                        ),
                        // Add TabBarView for displaying content
                        Expanded(
                          child: TabBarView(
                            children: [
                              ItemListView(typeId: widget.typeId, categoryId: widget.categoryId,),
                              ExpiringItemListView(typeId: widget.typeId, categoryId: widget.categoryId,),
                              ExpiredItemListView(typeId: widget.typeId, categoryId: widget.categoryId,),
                            ],
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
      },
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_cubit.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_state.dart';
import '../../manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../manager/import_from_excel_cubit/import_from_excel_cubit.dart';
import '../../manager/import_from_excel_cubit/import_from_excel_state.dart';
import '../create_item_view.dart';
import '../search_view.dart';
import 'item_list_view.dart';

class AllItemsBody extends StatelessWidget {
  const AllItemsBody({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    ImportFromExcelCubit importCubit = ImportFromExcelCubit.get(context);
    return BlocConsumer<ImportFromExcelCubit, ImportFromExcelState>(
      listener: (contextImport, stateImport) {
        if(stateImport is SelectedFileSuccess) {
          ImportFromExcelCubit.get(context).fetchImportFromExcel(
            excelFile: importCubit.selectedImage!,
          );
        }
        if (stateImport is ImportFromExcelFailure) {
          ScaffoldMessenger.of(contextImport).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('import_items_failed'))),
          );
        } else if (stateImport is ImportFromExcelSuccess) {
          contextImport.read<GetAllItemsCubit>().fetchAllItems(
              paginate: 50,
          );
          ScaffoldMessenger.of(contextImport).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('items_imported_successfully'))),
          );
        } else if (stateImport is SelectedFileFailure) {
          ScaffoldMessenger.of(contextImport).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('file_picked_failed'))),
          );
        } else if (stateImport is SelectedFileEmpty) {
          ScaffoldMessenger.of(contextImport).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('pick_file_first'))),
          );
        }
      },
      builder: (contextImport, stateImport) {
        return BlocConsumer<ExportToExcelCubit, ExportToExcelState>(
          listener: (context, state) {
            if (state is ExportToExcelFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('export_items_failed'))),
              );
            } else if (state is ExcelFileSaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('items_exported_successfully'))),
              );
            }
          },
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: AppPadding.p16,
                  bottom: AppPadding.p16,
                  start: AppPadding.p16,
                  end: AppPadding.p16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Tooltip(
                                message: AppLocalizations.of(context).translate('import_items'),
                                child: GestureDetector(
                                  onTap: () {
                                    ImportFromExcelCubit.get(context).pickImage();
                                  },
                                  child: circleIconWidget(
                                      icon: FontAwesomeIcons.fileImport,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      radius: 30.0,
                                      size: 25.0
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('export_items'),
                                child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<ExportToExcelCubit>(context).fetchExportToExcel(fields: ["id","name","quantity"]);
                                  },
                                  child: circleIconWidget(
                                      icon: FontAwesomeIcons.fileExport,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      radius: 30.0,
                                      size: 25.0
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('search'),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => SearchView(
                                          typeId: typeId,
                                          categoryId: categoryId,
                                        ),
                                        transitionDuration: Duration.zero,
                                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                      ),
                                    );
                                  },
                                  child: circleIconWidget(
                                      icon: Icons.search_sharp,
                                      backgroundColor: Colors.transparent,
                                      color: ColorManager.blue,
                                      size: AppSize.s30,
                                      radius: AppSize.s20,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: AppLocalizations.of(context).translate('add_item'),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateItemView(
                                        typeId: typeId,
                                        categoryId: categoryId,
                                      ),),
                                    );
                                  },
                                  child: circleIconWidget(
                                    icon: Icons.add_circle_outline,
                                    backgroundColor: Colors.transparent,
                                    color: ColorManager.blue,
                                    size: AppSize.s30,
                                    radius: AppSize.s20,
                                  ),
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
                            color: ColorManager.bc2,
                            borderRadius: BorderRadius.circular(AppSize.s12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppLocalizations.of(context).translate('rank'),
                                style: StyleManager.body1Regular(),
                              ),
                              const SizedBox(width: AppSize.s50,),
                              Center(
                                child: Text(
                                  AppLocalizations.of(context).translate('name'),
                                  style: StyleManager.body1Regular(color: ColorManager.blackColor),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                AppLocalizations.of(context).translate('quantity'),
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
*//*SizedBox(
                      height: AppSize.s24,
                      child: AppBar(
                        bottom: const TabBar(
                          indicatorColor: ColorManager.bc4,
                          labelColor: ColorManager.bc4,
                          unselectedLabelColor: ColorManager.bc5,
                          tabs: [
                            Tab(text: 'All Items'),
                            Tab(text: 'Expiring Items'),
                            //Tab(text: 'Expired Items'),
                          ],
                        ),
                      ),
                    ),
                    const TabBarView(
                      children: [
                        ItemListView(),
                        ExpiringItemListView()
                      ],
                    ),*//*

                    const ItemListView(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}*/
