import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../manger/create_staff_cubit/create_staff_cubit.dart';
import '../../manger/create_staff_cubit/create_staff_state.dart';
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
  List<String> items = ['secr', 'wear'];
  String selectedItem = 'secr';

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
        print('No image selected or image data is unavailable.');
      }
    } catch (e) {
      print('Failed to pick image: $e');
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateStaffCubit, CreateStaffState>(
      listener: (context, state) {
        if (state is CreateStaffFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Staff created failed")),
          );
        } else if (state is CreateStaffSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Staff created successfully')),
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
                            image: DecorationImage(
                              image: AssetImage(AssetsManager.testImage),
                            )
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
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
                    obscureText: CreateStaffCubit.get(context).isPassShow,
                    suffixIcon: CreateStaffCubit.get(context).suffixIcon,
                    onPressed: (){
                      CreateStaffCubit.get(context).changePassVisibility();
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
                        roleController.text = selectedItem;
                        print(roleController.text);
                      });
                    },
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
                            Navigator.pop(context);
                          },
                          child: Text('Cancel', style: StyleManager.h4Regular(color: ColorManager.bc0)),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                          ),
                          onPressed: register,
                          child: state is CreateStaffLoading ? const Center(child: CircularProgressIndicator()) : Text('Create', style: StyleManager.h4Regular(color: ColorManager.bc0)),
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