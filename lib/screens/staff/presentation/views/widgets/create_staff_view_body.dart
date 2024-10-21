import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'dart:typed_data';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../widgets/custom_snack_bar.dart';
import '../../manger/create_staff_cubit/create_staff_cubit.dart';
import '../../manger/create_staff_cubit/create_staff_state.dart';
import '../../manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'custom_edit_text_field.dart';

class CreateStaffViewBody extends StatefulWidget {
  const CreateStaffViewBody({super.key});

  @override
  State<CreateStaffViewBody> createState() => _CreateStaffViewBodyState();
}

class _CreateStaffViewBodyState extends State<CreateStaffViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController userNameController;
  late final TextEditingController numberController;
  late final TextEditingController roleController;
  Uint8List? selectedImage;
  List<String> items = ['Secretary', 'Warehouse guard'];
  String selectedItem = 'Secretary';

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    numberController = TextEditingController();
    roleController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    numberController.dispose();
    roleController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );

      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
      } else {
        log('No image selected or image data is unavailable.');
      }
    } catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateStaffCubit>().fetchCreateStaff(
        name: userNameController.text,
        email: emailController.text,
        number: numberController.text,
        password: passwordController.text,
        role: roleController.text,
        imageBytes: selectedImage!,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('please_select_an_image'),);
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context).translate("please_select_an_image")}.')),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return BlocConsumer<CreateStaffCubit, CreateStaffState>(
      listener: (context, state) {
        if (state is CreateStaffFailure) {
          //context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
          context.go('/manager_home?tab=1');
          //Navigator.pop(context);
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('staff_created_failed'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(local.translate("staff_created_failed"))),
          );*/
          context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
        } else if (state is CreateStaffSuccess) {
          //context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
          context.go('/manager_home?tab=1');
          //Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('staff_created_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(local.translate("staff_created_successfully"))),
          );*/
          context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
        } else if (state is ImagePickedSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('image_picked_successfully'),);
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(local.translate("image_picked_successfully"))),
          );*/
        }
      },
      builder: (context, state) =>  Center(
        child: Padding(
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
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      selectedImage != null
                          ? Container(
                        height: MediaQuery.of(context).size.width * .095,
                        width: MediaQuery.of(context).size.width * .095,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(70.0),
                            border: Border.all(
                              width: 0.1,
                              color: Colors.black,
                            ),
                            image: DecorationImage(
                              image: MemoryImage(selectedImage!),
                            )
                        ),
                      )
                          : Container(
                        height: MediaQuery.of(context).size.width * .095,
                        width: MediaQuery.of(context).size.width * .095,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(70.0),
                            border: Border.all(
                              width: 0.1,
                              color: Colors.black,
                            ),
                            image: const DecorationImage(
                              image: AssetImage(AssetsManager.testImage),
                            )
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt_outlined),
                        onPressed: pickImage,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    hintText: local.translate("full_name"),
                    controller: userNameController,
                    validator: (value) => value!.isEmpty ? local.translate("validate_required") : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: emailController,
                    hintText: local.translate("email"),
                    validator: (value) => value!.isEmpty ? local.translate("validate_required") : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: passwordController,
                    hintText: local.translate("password"),
                    validator: (value) => value!.isEmpty ? local.translate("validate_required") : null,
                    enabled: true,
                    obscureText: CreateStaffCubit.get(context).isPassShow,
                    suffixIcon: CreateStaffCubit.get(context).suffixIcon,
                    onPressed: (){
                      CreateStaffCubit.get(context).changePassVisibility();
                    }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: numberController,
                    hintText: local.translate("number"),
                    validator: (value) => value!.isEmpty ? local.translate("validate_required") : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    items: items.map(
                          (selectedItem) => DropdownMenuItem<String>(
                        value: selectedItem,
                        child: Text(selectedItem),
                      ),
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value!;
                        value == "Warehouse guard" ? roleController.text = "warehouseguard" : roleController.text = "secretary";
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return local.translate("please_select_role");
                      }
                      return null;
                    },
                    hint: Text(
                        local.translate("role")
                    ),
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
                          onPressed: state is CreateStaffLoading ? () {} : (){
                            context.go('/manager_home?tab=1');
                            //Navigator.pop(context);
                          },
                          child: Text(local.translate("cancel"), style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: register,
                          child: state is CreateStaffLoading ? const Center(child: CircularProgressIndicator()) : Text(local.translate("create"), style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}