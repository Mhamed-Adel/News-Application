import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/shared/component/component.dart';

import '../../modules/news_app/search/search_screen.dart';
import 'cubit2/cubit2.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
    listener: (BuildContext context, state) {  },  
    builder: (BuildContext context, state) { 
      var cubit = NewsCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title:  const Text('News App'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, 
            icon:  const Icon(Icons.search)),
            IconButton(
              onPressed:(){
                AppCubit.get(context).changeThemeMode();
              } ,
              icon: const Icon(Icons.brightness_4_outlined))
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          items:
          cubit.navItems,
          onTap: (index) {
          cubit.changeNavBar(index);
          },
          ),
      );
    }, 
    
      
    );
  }
}
