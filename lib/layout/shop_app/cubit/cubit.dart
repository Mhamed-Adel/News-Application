
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app_model/categories_model.dart';
import 'package:untitled/models/shop_app_model/favirotes_model.dart';
import 'package:untitled/models/shop_app_model/home_model.dart';
import 'package:untitled/models/shop_app_model/user_model.dart';
import 'package:untitled/modules/shop_app/category/category_screen.dart';
import 'package:untitled/modules/shop_app/favirotes/favirotes_sceen.dart';
import 'package:untitled/modules/shop_app/home/products_screen.dart';
import 'package:untitled/modules/shop_app/settings/settings_screen.dart';
import 'package:untitled/shared/component/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/models/shop_app_model/change_favirotes_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoryScreen(),
      const FavirotesScreen(),
     SettingsScreen(),
  ];

  void changeScreens(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  HomeModel? homeModel;
  Map<dynamic ,dynamic> favirotes = {};
  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) 
    {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.status);
      for (var element in homeModel!.data.products) {
        favirotes.addAll({
          element.id : element.inFavorites
        });
      }
      emit(ShopHomeDataSuccessState());
    }
    ).catchError((error) 
    {
      emit(ShopHomeDataErrorState());
      print(error.toString());
    }
    );
  }
      CategoriesModel? categoriesModel;

  void getCategoryData(){
    DioHelper.getData(url: GATCATEGORIES).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategorySuccessState());
    }).catchError((error){
      emit(ShopCategoryErrorState());
    });
  }
  ChangeFavirotesModel? favirotesModel;

  void changeFavirotes(int productId){
    favirotes[productId] = !favirotes[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token, 
      data: {
            'product_id' : productId,
      }).then((value) {
        favirotesModel = ChangeFavirotesModel.fromJson(value.data);
        print(value.data);
        getFavoritesData();
        emit(ShopChangeFavoritesSuccessState());
      }).catchError((error){

        emit(ShopChangeFavoritesErrorState());
      });
  }

 FavoritesModel? getFavoritesModel;
void getFavoritesData(){
  emit(ShopFavoritesLoadingState());
  DioHelper.getData(
    url: FAVORITES,
    token: token
    ).then((value) {
      getFavoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error){

      print(error.toString());
      emit(ShopFavoritesErrorState());
    });
}

    UserModel? userModel;
void getUserData(){
  emit(ShopUserDataLoadingState());
  DioHelper.getData(
    url: PROFILE,
    token: token
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopUserDataSuccessState(userModel!));
    }).catchError((error){

      print(error);
      emit(ShopUserDataErrorState(error.toString()));
    });}


void updateUserData({
  required String name,
  required String email,
  required String phone

}){
  emit(ShopUpdateUserDataLoadingState());
  DioHelper.putData(
    url: UPDATEPROFILE,
    token: token, 
    data: {
    'name': name,
    'email': email,
    'phone': phone,
    }
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopUpdateUserDataSuccessState(userModel!));
    }).catchError((error){

      print(error);
      emit(ShopUpdateUserDataErrorState(error.toString()));
    });}


}