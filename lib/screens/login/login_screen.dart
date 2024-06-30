import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
     static String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  _disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    _initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    var width= MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
        return Scaffold(
      body: SelectionArea(
        child: Center(
        
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal:width/3,// AppSize.s220
              vertical: width/14
              ),
            child: Card(
                   elevation: AppSize.s10,
                   color: ColorManager.bc1,
                   shadowColor: ColorManager.bc2,
                   //shape: ShapeBorder.lerp(   ),
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
                        style:StyleManager.h1Bold(color: ColorManager.bluelight) ,
                      ),
                  const SizedBox(height: AppSize.s10),
                  Text(
                          'Manage Your Warehouse Efficiently and Effectively', 
                         style:StyleManager.body2Medium(color: ColorManager.bluelight) ,
                      ),
                  const SizedBox(height: AppSize.s30),
                   TextFormField(
                    controller: emailController,
                     validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintStyle: TextStyle(color:ColorManager.bc3),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                   TextFormField(
                    controller: passwordController,
                     validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                    decoration:const InputDecoration(
                      labelText: 'Password',
                      hintStyle: TextStyle(color:ColorManager.bc3),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: AppSize.s4),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:  AppSize.s12,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: (){},
                           child: Text('Forget Password?',style: StyleManager.button2(color: ColorManager.navyBlue),),
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
                            backgroundColor: WidgetStateProperty.all(ColorManager.bluelight ),
                            ),
                          onPressed: (){
                             if (_formKey.currentState!.validate()) {} else {}
                          },
                         child: Text('\t\t\t      Login      \t\t\t',style: StyleManager.h4Regular(color: ColorManager.bc0),),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                 

                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s12,vertical: AppSize.s12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         Text('Not registered yet?',style: StyleManager.labelRegular(color: ColorManager.bc3),),
                           TextButton(
                            onPressed: ()
                            {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> RegisterScreen()) );
                            },
                           child: Text('Create an account',style: StyleManager.labelMedium(color: ColorManager.bluelight),),
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
            );
    
  }
}