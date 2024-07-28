import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';

import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../staff/presentation/views/widgets/custom_edit_text_field.dart';
import '../../manager/create_item_cubit/create_item_cubit.dart';
import '../../manager/create_item_cubit/create_item_state.dart';

class CreateItemViewBody extends StatelessWidget {
  CreateItemViewBody({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController expiredDateController = TextEditingController();
  final TextEditingController minimumQuantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final int typeId;
  final int categoryId;
  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateItemCubit, CreateItemState>(
      listener: (BuildContext context, state) {
        if (state is CreateItemSuccess) {
          context.read<GetAllItemsCubit>().fetchAllItems(
            paginate: paginate
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item created successfully")),
          );
        } else if (state is CreateItemFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item created failed")),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3,
            vertical: MediaQuery.of(context).size.width / 79,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    hintText: "Name",
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: quantityController,
                    hintText: 'Quantity',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: expiredDateController,
                    hintText: 'Expired date',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: minimumQuantityController,
                    hintText: 'Minimum quantity',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: state is CreateItemLoading ? () {} : (){
                            Navigator.pop(context);
                        },
                          child: Text('Cancel', style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: (){
                            CreateItemCubit.get(context).fetchCreateItem(
                              name: nameController.text,
                              typeId: typeId,
                              categoryId: categoryId,
                              quantity: int.parse(quantityController.text),
                              description: descriptionController.text,
                              expiredDate: expiredDateController.text,
                              minimumQuantity: int.parse(minimumQuantityController.text),
                            );
                          },
                          child: state is CreateItemLoading ? const Center(child: CircularProgressIndicator()) : Text('Create', style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
