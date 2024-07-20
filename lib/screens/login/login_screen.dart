import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/login/stafflogin_screen.dart';
import '../../Bloc/auth/login_cubit.dart';
import '../../Bloc/auth/login_state.dart';
import '../../firebase_messaging_service.dart';
import '../../core/utils/app_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../widgets/general_widgets/loading_indicator.dart';
import '../register/register_screen.dart';
import '../../widgets/general_widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        String? fcmToken = await FirebaseMessagingService.getFcmToken();
        if (fcmToken != null) {
          print("Attempting login with email: ${emailController.text}, password: ${passwordController.text}, and FCM token: $fcmToken");
          context.read<LoginCubit>().login(
            email: emailController.text,
            password: passwordController.text,
            fcmToken: fcmToken,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unable to get FCM token. Please try again later.')),
          );
        }
      } catch (e) {
        print("Error during login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error retrieving FCM token. Please try again later.')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/');

          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: SelectionArea(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width / 3,
                              vertical: width / 14,
                            ),
                            child: Card(
                              elevation: AppSize.s10,
                              color: ColorManager.bc1,
                              shadowColor: ColorManager.bc2,
                              child: Padding(
                                padding: const EdgeInsets.all(AppSize.s30),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Spacer(),
                                      Text(
                                        'Login',
                                        style: StyleManager.h1Bold(color: ColorManager.bluelight),
                                      ),
                                      const SizedBox(height: AppSize.s10),
                                      Text(
                                        'Manage Your Warehouse Efficiently and Effectively',
                                        style: StyleManager.body2Medium(color: ColorManager.bluelight),
                                      ),
                                      const SizedBox(height: AppSize.s30),
                                      CustomTextFormField(
                                        controller: emailController,
                                        labelText: 'Email',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required*';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextFormField(
                                        controller: passwordController,
                                        labelText: 'Password',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required*';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                      ),
                                      const SizedBox(height: AppSize.s4),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: AppSize.s12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              const Spacer(),
                                              TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  'Forget Password?',
                                                  style: StyleManager.button2(color: ColorManager.navyBlue),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Spacer(),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: WidgetStateProperty.all(ColorManager.bluelight),
                                              ),
                                              onPressed: login,
                                              child: Text(
                                                'Login',
                                                style: StyleManager.h4Regular(color: ColorManager.bc0),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: AppSize.s12, vertical: AppSize.s12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Not registered yet?',
                                                style: StyleManager.labelRegular(color: ColorManager.bc3),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(builder: (_) => StaffLoginScreen()),
                                                  );
                                                },
                                                child: Text(
                                                  'Create an account',
                                                  style: StyleManager.labelMedium(color: ColorManager.bluelight),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (isLoading) const FullscreenLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
