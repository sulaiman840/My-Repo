import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../data/models/show_all_staff_model.dart';
import '../../manger/featured_staff_cubit/featured_staff_cubit.dart';
import '../../manger/update_staff_cubit/update_staff_cubit.dart';
import '../../manger/update_staff_cubit/update_staff_state.dart';
import 'custom_edit_text_field.dart';

class UpdateStaffViewBody extends StatefulWidget {
  const UpdateStaffViewBody({Key? key, required this.allStaff}) : super(key: key);

  final ShowAllStaffModel allStaff;

  @override
  State<UpdateStaffViewBody> createState() => _UpdateStaffViewBodyState();
}

class _UpdateStaffViewBodyState extends State<UpdateStaffViewBody> {

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
    emailController = TextEditingController(text: widget.allStaff.email);
    passwordController = TextEditingController();
    userNameController = TextEditingController(text: widget.allStaff.name);
    numberController = TextEditingController(text: (widget.allStaff.number).toString());
    roleController = TextEditingController(text: widget.allStaff.role);
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
      context.read<UpdateStaffCubit>().fetchUpdateStaff(
        id: widget.allStaff.id,
        name: userNameController.text,
        email: emailController.text,
        number: numberController.text,
        password: passwordController.text,
        role: roleController.text,
        imageBytes: selectedImage!,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateStaffCubit, UpdateStaffState>(
      listener: (context, state) {
        if (state is UpdateStaffFailure) {
          context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Staff Updated failed")),
          );
        } else if (state is UpdateStaffSuccess) {
          context.read<FeaturedStaffCubit>().fetchFeaturedStaff();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Staff Updated successfully')),
          );
        } else if (state is ImagePickedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image picked successfully')),
          );
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
                    hintText: "Full name",
                    controller: userNameController,
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
                    textCapitalization: TextCapitalization.words,
                    enabled: true,
                    obscureText: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      validator: (value) => value!.isEmpty ? 'Required*' : null,
                      enabled: true,
                      obscureText: UpdateStaffCubit.get(context).isPassShow,
                      suffixIcon: UpdateStaffCubit.get(context).suffixIcon,
                      onPressed: (){
                        UpdateStaffCubit.get(context).changePassVisibility();
                      }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .02),
                  CustomEditTextField(
                    controller: numberController,
                    hintText: 'Number',
                    validator: (value) => value!.isEmpty ? 'Required*' : null,
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
                        value == "Warehouse guard" ? roleController.text = "warehourseguard" : roleController.text = "secr";
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please select role!';
                      }
                      return null;
                    },
                    hint: const Text(
                        "Role"
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
                          onPressed: state is UpdateStaffLoading ? () {} : (){
                            Navigator.pop(context);
                          },
                          child: Text('Cancel', style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: register,
                          child: state is UpdateStaffLoading ? const Center(child: CircularProgressIndicator()) : Text('Save', style: StyleManager.h4Regular(color: ColorManager.bc0)),
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

/*class UpdateSecurityInformation extends StatelessWidget {
  UpdateSecurityInformation({Key? key, required this.showStaffDetailsModel}) : super(key: key);

  final ShowStaffDetailsModel showStaffDetailsModel;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Uint8List? selectedImage;

  @override
  Widget build(BuildContext context) {
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
                controller: emailController,
                hintText: 'Email',
                validator: (value) => value!.isEmpty ? 'Required*' : null,
                textCapitalization: TextCapitalization.words,
                enabled: true,
                obscureText: false,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .02),
              CustomEditTextField(
                controller: passwordController,
                hintText: 'Password',
                validator: (value) => value!.isEmpty ? 'Required*' : null,
                enabled: true,
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .02),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && selectedImage != null) {
                      context.read<UpdateStaffCubit>().fetchUpdateStaff(
                        id: showStaffDetailsModel.id,
                        name: "",
                        email: emailController.text,
                        number: "",
                        password: passwordController.text,
                        role: "",
                        imageBytes: selectedImage!,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select an image.')),
                      );
                    }
                  },
                  child: state is UpdateStaffLoading ? const Center(child: CircularProgressIndicator()) : Text('Save', style: StyleManage.h4Regular(color: ColorManager.bc0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
