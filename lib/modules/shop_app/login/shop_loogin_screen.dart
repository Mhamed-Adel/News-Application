

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';

import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/shop_register_screen.dart';
import 'package:untitled/shared/component/component.dart';
import 'package:untitled/shared/network/local/shared_helper.dart';

import '../../../shared/component/constants.dart';

class ShopLoginScreen extends StatelessWidget {

final  formKey = GlobalKey<FormState>();

  ShopLoginScreen({super.key}); 
  @override
  Widget build(BuildContext context) {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit()  ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context, state)  {
      if(state is ShopLoginSuccessState){
        if (state.loginModel.status){
          print (state.loginModel.message);
          print (state.loginModel.data!.token);
        CachHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
        {
        token = state.loginModel.data!.token;
        navigateAndFinish(context,  const ShopLayout(),
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
      builder: (context, state) {
        return Scaffold(
          
          appBar: AppBar(
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black
                      )),
                      Text('Login for more offers',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey
                      )),
                      const SizedBox(height:20.0,),
                              
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
                        isPassword : ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPress: (){
                        ShopLoginCubit.get(context).changePasswordVisibilty();
                        },
                        onSubmitted: (String? value){
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                          email: emailController.text, 
                          password: passwordController.text);
                          }
                        }
                        ),
                        const SizedBox(height: 16.0,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder: (BuildContext context)=>
                            defaultButton(
                            function: (){
                              if(formKey.currentState!.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                email: emailController.text, 
                                password: passwordController.text,
                                );
                                
                              }
                            }, 
                            text: 'LOGIN'),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                          
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? '),
                            TextButton(onPressed: (){
                              navigateTo(context, 
                              ShopRegisterScreen());
                            }, 
                            child: const Text('REGISTER'))
                          ],
                        ),
                        
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

      },
              ),
    );
  }
}