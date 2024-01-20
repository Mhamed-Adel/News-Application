import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit2/states2.dart';
import 'package:untitled/shared/network/local/shared_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit () :super(AppInitialState());
  
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  
  bool isDark = false;

  void changeThemeMode ({  bool? fromShared}){
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeMode());
    } else {
      isDark = !isDark;
    
    CachHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeMode());
    });}
    
  }
  

}