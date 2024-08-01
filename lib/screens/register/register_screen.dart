
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import '../../Bloc/auth/register_cubit.dart';
import '../../Bloc/auth/register_state.dart';
import '../../services/Auth_Services/auth_services.dart';
import '../../widgets/general_widgets/custom_text_form_field.dart';
import '../../core/utils/app_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController userNameController;
  late final TextEditingController numberController;
  late final TextEditingController roleController;
  Uint8List? selectedImage;

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
      context.read<RegisterCubit>().register(
        name: userNameController.text,
        email: emailController.text,
        number: numberController.text,
        password: passwordController.text,
        role: roleController.text,
        imageBytes: selectedImage!,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterService()),
      child: Scaffold(
        body: SelectionArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3,
                vertical: MediaQuery.of(context).size.width / 79,
              ),
              child: Card(
                elevation: 10,
                color: ColorManager.bc1,
                shadowColor: ColorManager.bc2,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration successful')),
                        );
                      } else if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Register', style: StyleManager.h1Bold(color: ColorManager.bluelight)),
                              if (selectedImage != null)
                                Container(
                                  height: 150,
                                  width: 150,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(selectedImage!),
                                    ),
                                  ),
                                ),
                              OutlinedButton(
                                onPressed: pickImage,
                                child: Text('Select Image'),
                              ),
                              SizedBox(height: 20),
                              CustomTextFormField(
                                controller: userNameController,
                                labelText: 'Name',
                                validator: (value) => value!.isEmpty ? 'Required*' : null,
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                controller: emailController,
                                labelText: 'Email',
                                validator: (value) => value!.isEmpty ? 'Required*' : null,
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                controller: passwordController,
                                labelText: 'Password',
                                validator: (value) => value!.isEmpty ? 'Required*' : null,
                                obscureText: true,
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                controller: numberController,
                                labelText: 'Number',
                                validator: (value) => value!.isEmpty ? 'Required*' : null,
                              ),
                              SizedBox(height: 10),
                              CustomTextFormField(
                                controller: roleController,
                                labelText: 'Role',
                                validator: (value) => value!.isEmpty ? 'Required*' : null,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                                ),
                                onPressed: register,
                                child: Text('Register', style: StyleManager.h4Regular(color: ColorManager.bc0)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                },
                                child: Text('Login', style: StyleManager.labelMedium(color: ColorManager.bluelight)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
