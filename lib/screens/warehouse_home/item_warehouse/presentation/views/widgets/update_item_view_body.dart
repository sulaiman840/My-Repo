import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../staff/presentation/views/widgets/custom_edit_text_field.dart';
import '../../../data/models/all_items_model.dart';
import '../../../data/models/expiring_soon_items_model.dart';
import '../../../data/models/search_items_model.dart';
import '../../manager/update_item_cubit/update_item_cubit.dart';
import '../../manager/update_item_cubit/update_item_state.dart';

class UpdateItemViewBody extends StatefulWidget {
  UpdateItemViewBody({Key? key, required this.allItems}) : super(key: key);

  final DataView allItems;

  @override
  State<UpdateItemViewBody> createState() => _UpdateItemViewBodyState();
}

class _UpdateItemViewBodyState extends State<UpdateItemViewBody> {
  TextEditingController? nameController;

  TextEditingController? quantityController;

  TextEditingController? descriptionController;

  TextEditingController? expiredDateController;

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expiredDateController!.text = DateFormat('yyyy-MM-dd').format(selectedDate!); // Update TextFormField
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: widget.allItems.name);
    quantityController = TextEditingController(text: widget.allItems.quantity.toString());
    descriptionController = TextEditingController(text: widget.allItems.description);
    expiredDateController = TextEditingController(text: widget.allItems.expiredDate);
    return BlocConsumer<UpdateItemCubit, UpdateItemState>(
      listener: (BuildContext context, state) {
        if (state is UpdateItemSuccess) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          //Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_successfully'))),
          );
        } else if (state is UpdateItemFailure) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_failed'))),
          );
        }
      },
      builder: (BuildContext context, Object? state) {
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
                    hintText: AppLocalizations.of(context).translate('name'),
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: quantityController,
                    hintText: AppLocalizations.of(context).translate('quantity'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context).translate('description'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  widget.allItems.expiredDate != null ? CustomEditTextField(
                    readOnly: true,
                    controller: expiredDateController,
                    hintText: AppLocalizations.of(context).translate('expired_date'),
                    validator: null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                    onTap: () {
                      _selectDate(context);
                      log(expiredDateController!.text);
                    },
                  ) : const SizedBox(height: 0, width: 0,),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: state is UpdateItemLoading ? () {} : (){
                            context.go('/AllCategoryView/${widget.allItems.typeId}');
                            //Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context).translate('cancel'), style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: (){
                            UpdateItemCubit.get(context).fetchUpdateItem(
                              id: widget.allItems.id,
                              name: nameController!.text,
                              expiredDate: expiredDateController!.text,
                              quantity: int.parse(quantityController!.text),
                              description: descriptionController!.text,
                              typeId: widget.allItems.typeId,
                              categoryId: widget.allItems.categoryId,
                            );
                          },
                          child: state is UpdateItemLoading ? const Center(child: CircularProgressIndicator()) : Text('Save', style: StyleManager.h4Regular(color: ColorManager.bc0)),
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

class UpdateExpiringItemViewBody extends StatefulWidget {
  UpdateExpiringItemViewBody({Key? key, required this.allItems}) : super(key: key);

  final DataExpiring allItems;

  @override
  State<UpdateExpiringItemViewBody> createState() => _UpdateExpiringItemViewBodyState();
}

class _UpdateExpiringItemViewBodyState extends State<UpdateExpiringItemViewBody> {
  TextEditingController? nameController;

  TextEditingController? quantityController;

  TextEditingController? descriptionController;

  TextEditingController? expiredDateController;

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expiredDateController!.text = DateFormat('yyyy-MM-dd').format(selectedDate!); // Update TextFormField
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: widget.allItems.name);
    quantityController = TextEditingController(text: widget.allItems.quantity.toString());
    descriptionController = TextEditingController(text: widget.allItems.description);
    expiredDateController = TextEditingController(text: widget.allItems.expiredDate);
    return BlocConsumer<UpdateItemCubit, UpdateItemState>(
      listener: (BuildContext context, state) {
        if (state is UpdateItemSuccess) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          //Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('item_updated_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_successfully'))),
          );*/
        } else if (state is UpdateItemFailure) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('item_updated_failed'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_failed'))),
          );*/
        }
      },
      builder: (BuildContext context, Object? state) {
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
                    hintText: AppLocalizations.of(context).translate('name'),
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: quantityController,
                    hintText: AppLocalizations.of(context).translate('quantity'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context).translate('description'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  widget.allItems.expiredDate != null ? CustomEditTextField(
                    readOnly: true,
                    controller: expiredDateController,
                    hintText: AppLocalizations.of(context).translate('expired_date'),
                    validator: null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                    onTap: () {
                      _selectDate(context);
                      log(expiredDateController!.text);
                    },
                  ) : const SizedBox(height: 0, width: 0,),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: state is UpdateItemLoading ? () {} : (){
                            context.go('/AllCategoryView/${widget.allItems.typeId}');
                            //Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context).translate('cancel'), style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: (){
                            UpdateItemCubit.get(context).fetchUpdateItem(
                              id: widget.allItems.id,
                              name: nameController!.text,
                              expiredDate: expiredDateController!.text,
                              quantity: int.parse(quantityController!.text),
                              description: descriptionController!.text,
                              typeId: widget.allItems.typeId,
                              categoryId: widget.allItems.categoryId,
                            );
                          },
                          child: state is UpdateItemLoading ? const Center(child: CircularProgressIndicator()) : Text('Save', style: StyleManager.h4Regular(color: ColorManager.bc0)),
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

class UpdateSearchItemViewBody extends StatefulWidget {
  UpdateSearchItemViewBody({Key? key, required this.allItems}) : super(key: key);

  final DataSearch allItems;

  @override
  State<UpdateSearchItemViewBody> createState() => _UpdateSearchItemViewBodyState();
}

class _UpdateSearchItemViewBodyState extends State<UpdateSearchItemViewBody> {
  TextEditingController? nameController;

  TextEditingController? quantityController;

  TextEditingController? descriptionController;

  TextEditingController? expiredDateController;

  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        expiredDateController!.text = DateFormat('yyyy-MM-dd').format(selectedDate!); // Update TextFormField
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: widget.allItems.name);
    quantityController = TextEditingController(text: widget.allItems.quantity.toString());
    descriptionController = TextEditingController(text: widget.allItems.description);
    expiredDateController = TextEditingController(text: widget.allItems.expiredDate);
    return BlocConsumer<UpdateItemCubit, UpdateItemState>(
      listener: (BuildContext context, state) {
        if (state is UpdateItemSuccess) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          //Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('item_updated_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_successfully'))),
          );*/
        } else if (state is UpdateItemFailure) {
          context.go('/AllCategoryView/${widget.allItems.typeId}');
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('item_updated_failed'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).translate('item_updated_failed'))),
          );*/
        }
      },
      builder: (BuildContext context, Object? state) {
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
                    hintText: AppLocalizations.of(context).translate('name'),
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: quantityController,
                    hintText: AppLocalizations.of(context).translate('quantity'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: descriptionController,
                    hintText: AppLocalizations.of(context).translate('description'),
                    validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('validate_required') : null,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  widget.allItems.expiredDate != null ? CustomEditTextField(
                    readOnly: true,
                    controller: expiredDateController,
                    hintText: AppLocalizations.of(context).translate('expired_date'),
                    validator: null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                    onTap: () {
                      _selectDate(context);
                      log(expiredDateController!.text);
                    },
                  ) : const SizedBox(height: 0, width: 0,),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: state is UpdateItemLoading ? () {} : (){
                            context.go('/AllCategoryView/${widget.allItems.typeId}');
                            //Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context).translate('cancel'), style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: (){
                            UpdateItemCubit.get(context).fetchUpdateItem(
                              id: widget.allItems.id,
                              name: nameController!.text,
                              expiredDate: expiredDateController!.text,
                              quantity: int.parse(quantityController!.text),
                              description: descriptionController!.text,
                              typeId: widget.allItems.typeId,
                              categoryId: widget.allItems.categoryId,
                            );
                          },
                          child: state is UpdateItemLoading ? const Center(child: CircularProgressIndicator()) : Text('Save', style: StyleManager.h4Regular(color: ColorManager.bc0)),
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