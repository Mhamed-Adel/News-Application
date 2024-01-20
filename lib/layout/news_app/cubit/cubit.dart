import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/search/search_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() :super (NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business'
          ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science'
          ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports'
          ),
  ];
  void changeNavBar (int index){
    currentIndex = index;
    if(index == 1) {
      getScience();
    }
    if(index == 2) {
      getSports();
    }
    emit(NewsBottomNavState());
  }
  List <Widget> screens = [
     const BusinessScreen(),
     const ScienceScreen(),
    const SportsScreen(),
    SearchScreen()
    
  ];
  List <dynamic> business= [];
  List <dynamic> sports= [];
  List <dynamic> science = [];
  List <dynamic> search= [];

  void getBusiness(){    
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
    url:'api/1/news' ,
    query: {'country':'eg',
            'category':'top',
            'apiKey':'pub_20098a011a98b295090c158369b861a167b3f',
            }
    ).then((value)  
    {
      business = value.data['results'];
      emit(NewsGetBusinessSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
   void getScience(){    
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
    url:'api/1/news' ,
    query: {'country':'eg',
            'category':'technology',
            'apiKey':'pub_20098a011a98b295090c158369b861a167b3f',
            }
    ).then((value)  
    {
      science = value.data['results'];
      emit(NewsGetScienceSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
    }
    else{
      emit(NewsGetBusinessSuccessState());
    }
  }
void getSports(){    
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
    url:'api/1/news' ,
    query: {'country':'eg',
            'category':'sports',
            'apiKey':'pub_20098a011a98b295090c158369b861a167b3f',
            }
    ).then((value)  
    {
      sports = value.data['results'];
      emit(NewsGetSportsSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
    }else{
      emit(NewsGetBusinessSuccessState());
    }
  }
void getSearch(String value){    
    emit(NewsGetSearchLoadingState());
    // search = [];
      DioHelper.getData(
    url:'api/1/news' ,
    query: {
            'q':value,
            'apiKey':'pub_20098a011a98b295090c158369b861a167b3f',
            }
    ).then((value)  
    {
      search = value.data['results'];
      emit(NewsGetSearchSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
    }




  }


