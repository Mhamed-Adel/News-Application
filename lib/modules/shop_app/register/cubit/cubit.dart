import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_app_model/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit () : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  
  late ShopLoginModel loginModel;
  void userRegister ({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name' : name,
      'email' : email,
      'password' : password,
      'phone' : phone,
    }).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
    IconData suffix = Icons.visibility_outlined;
    bool isPassword = true;

    void changePasswordVisibilty(){
      isPassword = !isPassword;
      suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
      emit(ShopPasswordVisibiltyState());

    }
}