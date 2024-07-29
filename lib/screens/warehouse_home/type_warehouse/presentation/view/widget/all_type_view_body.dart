import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/utils/style_manager.dart';
import '../../../../widget/circular_icon_widget.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../../widget/elevated_btn_widget.dart';
import '../../../data/repos/type_repo_impl.dart';
import '../../manager/create_type_cubit/create_type_cubit.dart';
import '../../manager/create_type_cubit/create_type_state.dart';
import '../../manager/delete_type_cubit/delete_type_cubit.dart';
import '../../manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'card_widget.dart';
import 'type_grid_view.dart';

class AllTypeViewBody extends StatelessWidget {
  AllTypeViewBody({Key? key}) : super(key: key);

  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTypeCubit, CreateTypeState>(
      listener: (context, state) {
        if (state is CreateTypeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Type created failed")),
          );
        } else if (state is CreateTypeSuccess) {
          context.read<GetAllTypeCubit>().fetchAllTypes();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Type created successfully')),
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CardWidget(),
                const SizedBox(
                  height: AppSize.s24,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      elevatedbtn(
                        icon: circleIconWidget(
                          icon: Icons.add,
                          backgroundColor: ColorManager.orange,
                          color: ColorManager.bc0,
                        ),
                        text: 'Add New Type',
                        style: StyleManager.labelMedium(color: ColorManager.bc4),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogWidget(
                                title: 'Add new type',
                                hintText: 'Enter name',
                                controller: typeController,
                                onPressed: () {
                                  final createTypeCubit = context.read<CreateTypeCubit>();
                                  createTypeCubit.fetchCreateType(name: typeController.text);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  /*child: elevatedbtn(
                    icon: circleIconWidget(
                      icon: Icons.add,
                      backgroundColor: ColorManager.orange,
                      color: ColorManager.bc0,
                    ),
                    text: 'Add New Type',
                    style: StyleManager.labelMedium(color: ColorManager.bc4),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogWidget(
                            title: 'Add new type',
                            hintText: 'Enter name',
                            controller: typeController,
                            onPressed: () {
                              final createTypeCubit = context.read<CreateTypeCubit>();
                              createTypeCubit.fetchCreateType(name: typeController.text);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),*/
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  'Types',
                  style: StyleManager.h3Bold(color: ColorManager.blackColor),
                ),
                const SizedBox(
                  height: AppSize.s24,
                ),
                BlocProvider(
                  create: (context) {
                    return DeleteTypeCubit(
                      getIt.get<TypeRepoImpl>(),
                    );
                  },
                  child: const TypeGridView(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
