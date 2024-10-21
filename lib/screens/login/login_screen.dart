import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Bloc/auth/login_cubit.dart';
import '../../Bloc/auth/login_state.dart';
import '../../Bloc/user_role_cubit .dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/app_manager.dart';
import '../../firebase_messaging_service.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../widgets/general_widgets/loading_indicator.dart';
import '../../widgets/general_widgets/custom_text_form_field.dart';
import '../../core/utils/shared_preferences_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
        // Fetch new FCM token on login
        String? fcmToken = await FirebaseMessagingService.getFcmToken();
        if (fcmToken != null) {
          print(
              "Attempting login with email: ${emailController.text}, password: ${passwordController.text}, and FCM token: $fcmToken");

          context.read<LoginCubit>().login(
                email: emailController.text,
                password: passwordController.text,
                fcmToken: fcmToken,
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context).translate('unable_get_FCM_token'))),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context).translate('error_retrieving_FCM_token'))),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _handleLoginSuccess(BuildContext context) async {
    final userRoleCubit = context.read<UserRoleCubit>();
    await userRoleCubit.fetchUserRole();

    final String? role = userRoleCubit.state;
    if (role == "secretary") {
      context.go('/secretary_home');
    } else if (role == "manager") {
      context.go('/manager_home');
    } else if (role == "warehouseguard") {
      context.go('/warehouseHome');
    } else {
      context.go('/');
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
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const FullscreenLoadingIndicator();
          } else if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _handleLoginSuccess(context);
            });
          } else if (state is LoginFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            });
          }

          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Spacer(),
                                        Text(
                                          AppLocalizations.of(context).translate('login'),
                                          style: StyleManager.h1Bold(
                                              color: ColorManager.bluelight),
                                        ),
                                        const SizedBox(height: AppSize.s10),
                                        Text(
                                          AppLocalizations.of(context).translate('Manage Your Center Efficiently and Effectively'),
                                          style: StyleManager.body2Medium(
                                              color: ColorManager.bluelight),
                                        ),
                                        const SizedBox(height: AppSize.s30),
                                        CustomTextFormField(
                                          controller: emailController,
                                          labelText: AppLocalizations.of(context).translate('email'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(context).translate('validate_required');
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextFormField(
                                          controller: passwordController,
                                          labelText: AppLocalizations.of(context).translate('password'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(context).translate('validate_required');
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                        ),
                                        const SizedBox(height: AppSize.s4),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: AppSize.s12),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Spacer(),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          ColorManager
                                                              .bluelight),
                                                ),
                                                onPressed: login,
                                                child: Text(
                                                  AppLocalizations.of(context).translate('login'),
                                                  style: StyleManager.h4Regular(
                                                      color: ColorManager.bc0),
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
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
          );
        },
      ),
    );
  }
}
