import 'package:flutter/material.dart';
import 'package:project2/screens/login/login_screen.dart';

import '../../core/utils/app_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
   static const id = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
   Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController userNameController;
  late final TextEditingController numberController;
    late final TextEditingController roleController;


  

  _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    numberController = TextEditingController();
    roleController = TextEditingController();

  }

  _disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    numberController.dispose();
    roleController.dispose();
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


    var width= MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
        return Scaffold(
      body: SelectionArea(
        child: Center(
        
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal:width/3,// AppSize.s220
              vertical: width/79
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
                      
                //  const Spacer(),
                  Row(
                    children: [
                      
                   Text('Register',style:StyleManager.h1Bold(color: ColorManager.bluelight) ,
),
                 
                   const Spacer(),   
                  Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSize.s12,),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "https://wallpapers.com/images/hd/waving-technoblade-anime-fan-art-xjz8fyxbzakvitgq.jpg"),
                      ),
                    ),
                    Positioned(
                      bottom: -6,
                      left :60,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ],
                ),
                    ],
                  ),
                 // const SizedBox(height: AppSize.s2),

                  TextFormField(
                    //  controller: userNameController,
                       validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required*';
                              }
                              return null;
                            },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintStyle: TextStyle(color:ColorManager.bc3),
                        border: OutlineInputBorder(),
                      ),
                                       ),
                  const SizedBox(height: AppSize.s10),
                   TextFormField(
                   // controller: emailController,
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
                  const SizedBox(height: AppSize.s10),
                   TextFormField(
                    //controller: passwordController,
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
                   const SizedBox(height: AppSize.s10),
                   TextFormField(
                  //  controller: numberController,
                     validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                    decoration:const InputDecoration(
                      labelText: 'Number',
                      hintStyle: TextStyle(color:ColorManager.bc3),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  
                  const SizedBox(height: AppSize.s10),

                  TextFormField(
                    //  controller: roleController,
                       validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required*';
                              }
                              return null;
                            },
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        hintStyle: TextStyle(color:ColorManager.bc3),
                        border: OutlineInputBorder(),
                      ),
                                       ),
                  const SizedBox(height: AppSize.s10),
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
                         child: Text('\t\t\t    register   \t\t\t',style: StyleManager.h4Regular(color: ColorManager.bc0),),
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
                         Text('Already have an account?',style: StyleManager.labelRegular(color: ColorManager.bc3),),
                           TextButton(
                            onPressed: ()
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                            },
                           child: Text('Login',style: StyleManager.labelMedium(color: ColorManager.bluelight),),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2,),

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




/*Row(
                    children: [
                      
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                     child: TextFormField(
                    //  controller: userNameController,
                       validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required*';
                              }
                              return null;
                            },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintStyle: TextStyle(color:ColorManager.bc3),
                        border: OutlineInputBorder(),
                      ),
                                       ),
                   ),
                 
                   const Spacer(),   
                  Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          "https://wallpapers.com/images/hd/waving-technoblade-anime-fan-art-xjz8fyxbzakvitgq.jpg"),
                    ),
                    Positioned(
                      bottom: -15,
                      left :90,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                    ],
                  ),*/