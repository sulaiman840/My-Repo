import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/screens/item_warehouse/presentation/manager/import_from_excel_cubit/import_from_excel_state.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../../../../warehouse_home/widget/elevated_btn_widget.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_cubit.dart';
import '../../manager/export_to_excel_cubit/export_to_excel_state.dart';
import '../../manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../manager/import_from_excel_cubit/import_from_excel_cubit.dart';
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
            const SnackBar(content: Text("Import items failed")),
          );
        } else if (stateImport is ImportFromExcelSuccess) {
          contextImport.read<GetAllItemsCubit>().fetchAllItems(
              paginate: 50,
          );
          ScaffoldMessenger.of(contextImport).showSnackBar(
            const SnackBar(content: Text('items imported successfully')),
          );
        } else if (stateImport is SelectedFileFailure) {
          ScaffoldMessenger.of(contextImport).showSnackBar(
            const SnackBar(content: Text('File picked failed, try again!')),
          );
        } else if (stateImport is SelectedFileEmpty) {
          ScaffoldMessenger.of(contextImport).showSnackBar(
            const SnackBar(content: Text('Please pick a file first')),
          );
        }
      },
      builder: (contextImport, stateImport) {
        return BlocConsumer<ExportToExcelCubit, ExportToExcelState>(
          listener: (context, state) {
            if (state is ExportToExcelFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Export items failed")),
              );
            } else if (state is ExcelFileSaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('items exported successfully')),
              );
            }
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
                        Navigator.pop(context);
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
                              Tooltip(
                                message: "Import items",
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
                                message: "Export items",
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
                              GestureDetector(
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
                                    radius: 30.0,
                                    size: 25.0
                                ),
                              ),
                              elevatedbtn(
                                icon: circleIconWidget(
                                  icon: Icons.add,
                                  backgroundColor: ColorManager.orange,
                                  color: ColorManager.bc0,
                                ),
                                text: 'Add New Category',
                                style: StyleManager.labelMedium(color: ColorManager.bc4),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CreateItemView(
                                      typeId: typeId,
                                      categoryId: categoryId,
                                    ),),
                                  );
                                },
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
}
