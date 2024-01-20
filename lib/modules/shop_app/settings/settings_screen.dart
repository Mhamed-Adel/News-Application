import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/shared/component/component.dart';
import 'package:untitled/shared/component/constants.dart';

class SettingsScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
      if (state is ShopUserDataSuccessState){
        nameController.text = state.loginModel.data!.name!;
        emailController.text = state.loginModel.data!.email!;
        phoneController.text = state.loginModel.data!.phone!;
      }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context);
        nameController.text = model.userModel!.data!.name!;
        emailController.text =model.userModel!.data!.email!;
        phoneController.text =model.userModel!.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context) => Center(
            child: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  
                  children: [
                    if(state is ShopUpdateUserDataLoadingState) 
                    const LinearProgressIndicator(),
                    const SizedBox(height: 15.0,),
                  defaultFormFeild(
                    controller: nameController, 
                    type: TextInputType.name, 
                    label: 'User Name', 
                    prefix: Icons.person,
                    validate: (String? value) {
                      if(value!.isEmpty){
                        return 'please enter your name';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 15.0,),
                  defaultFormFeild(
                    controller: emailController, 
                    type: TextInputType.emailAddress, 
                    label: 'Email Address', 
                    prefix: Icons.email,
                    validate: (String? value) {
                      if(value!.isEmpty){
                        return 'please enter your email address';
                      }
                      return null;
                    },
                    ),
                    const SizedBox(height: 15.0,),
                  defaultFormFeild(
                    controller: phoneController, 
                    type: TextInputType.phone, 
                    label: 'Phone Number', 
                    prefix: Icons.phone_rounded,
                    validate: (String? value) {
                      if(value!.isEmpty){
                        return 'please enter your phone number';
                      }
                      return null;
                    },
                    ),const SizedBox(height: 15.0,),
                    defaultButton(
                      function: (){
                      if (formKey.currentState!.validate()){
                          
                          ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text
                          );
                          
                        
                      }
                      }, 
                      text: 'UPDATE',
                      
                      ),
                    const SizedBox(height: 15.0,),
                    defaultButton(
                      function: (){
                      sigOut(context);
                      },
                        text: 'LOGOUT'),
              
                    
                  ],
                ),
              ),
                    ),
            ),
          ),
        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );

      },
          );
}}