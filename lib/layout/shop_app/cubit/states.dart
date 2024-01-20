
import '../../../models/shop_app_model/user_model.dart';

abstract class ShopStates {}

class ShopIntitialState extends ShopStates{}

class ShopBottomNavState extends ShopStates{}

class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{}

class ShopCategorySuccessState extends ShopStates{}
class ShopCategoryErrorState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}
class ShopChangeFavoritesErrorState extends ShopStates{}

class ShopFavoritesLoadingState extends ShopStates{}
class ShopFavoritesSuccessState extends ShopStates{}
class ShopFavoritesErrorState extends ShopStates{}

class ShopUserDataLoadingState extends ShopStates{
  
}
class ShopUserDataSuccessState extends ShopStates{
  final UserModel loginModel;

  ShopUserDataSuccessState(this.loginModel);

}
class ShopUserDataErrorState extends ShopStates{
  final String error;

  ShopUserDataErrorState(this.error);
}
class ShopUpdateUserDataLoadingState extends ShopStates{
  
}
class ShopUpdateUserDataSuccessState extends ShopStates{
  final UserModel loginModel;

  ShopUpdateUserDataSuccessState(this.loginModel);

}
class ShopUpdateUserDataErrorState extends ShopStates{
  final String error;

  ShopUpdateUserDataErrorState(this.error);
}