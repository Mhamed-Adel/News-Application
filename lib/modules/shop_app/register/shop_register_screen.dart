import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/register/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/component/component.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/network/local/shared_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
    final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context, state) {
          if(state is ShopRegisterSuccessState){
        if (state.loginModel.status){
          print (state.loginModel.message);
          print (state.loginModel.data!.token);
        CachHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
        {
        token = state.loginModel.data!.token!;
        navigateAndFinish(context, const ShopLayout(),
        );
        });
        }
        else{
            print(state.loginModel.message);
        showToast(
          text: state.loginModel.message.toString(), 
          state: ToastState.ERROR);
        }
      }
          
          },
          builder:(context, state) { 
          return  Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text('REGISTER NOW',
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              color: defaultColor
                            ),
                            
                            ),
                          ),
              
                          const SizedBox(height:15.0,),
                                  
                          defaultFormFeild(
                            controller: nameController, 
                            type: TextInputType.name, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }, 
                            label: 'User Name', 
                            prefix: Icons.person),
                          const SizedBox(height: 16.0,),
              
                            defaultFormFeild(
                            controller: emailController, 
                            type: TextInputType.emailAddress, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            }, 
                            label: 'Email Address', 
                            prefix: Icons.email),
                          
                          const SizedBox(height: 16.0,),
                          defaultFormFeild(
                            controller: passwordController, 
                            type: TextInputType.visiblePassword, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            }, 
                            label: 'Password', 
                            prefix: Icons.lock,
                            isPassword : ShopRegisterCubit.get(context).isPassword,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixPress: (){
                            ShopRegisterCubit.get(context).changePasswordVisibilty();
                            },
                            
                            ),
                            const SizedBox(height: 16.0,),
              
                            defaultFormFeild(
                            controller: phoneController, 
                            type: TextInputType.phone, 
                            validate: (String? value){
                              if(value!.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            }, 
                            label: 'phone', 
                            prefix: Icons.phone
                            ),
                            const SizedBox(height: 15.0,),
                            ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState ,
                              builder: (BuildContext context)=>
                                defaultButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    ShopRegisterCubit.get(context).userRegister(
                                    name : nameController.text,
                                    email: emailController.text, 
                                    password: passwordController.text,
                                    
                                    phone : phoneController.text,
                                    );
                                    
                                  }
                                }, 
                                text: 'REGISTER'),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                              
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );}
  ),
  
      ),
    );
  }
}