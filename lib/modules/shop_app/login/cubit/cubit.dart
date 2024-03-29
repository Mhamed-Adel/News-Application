import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app_model/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit () : super(ShopLoginInitialState());


  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;
  void userLogin ({
    required String email,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    }).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
    IconData suffix = Icons.visibility_outlined;
    bool isPassword = true;

    void changePasswordVisibilty(){
      isPassword = !isPassword;
      suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
      emit(ShopChangePasswordVisibiltyState());

    }
}