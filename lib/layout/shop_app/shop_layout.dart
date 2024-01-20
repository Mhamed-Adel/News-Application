import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/modules/search/search.dart';
import 'package:untitled/shared/component/component.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {  }, 
        builder: (BuildContext context,  state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            title: const Text('SOUQ'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              }, icon:const Icon(Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
    
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
            cubit.changeScreens(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon:Icon(Icons.home_filled),
                label: 'Home' ),
                BottomNavigationBarItem(
                icon:Icon(Icons.category_outlined),
                label: 'Category' ),
                BottomNavigationBarItem(
                icon:Icon(Icons.favorite_border),
                label: 'Favorite' ),
                BottomNavigationBarItem(
                icon:Icon(Icons.settings_rounded),
                label: 'Settings' )
            ],
          ),
        );
          },
          ),
    );
  }
}