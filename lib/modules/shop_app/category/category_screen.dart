import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app_model/categories_model.dart';
import 'package:untitled/shared/component/component.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return  ListView.separated(
        itemBuilder: (context , index) => catBuilder(cubit.categoriesModel!.data.data[index]) , 
        separatorBuilder: (context, index) => myDivider(), 
        itemCount: cubit.categoriesModel!.data.data.length);
        },
      
    ) ;
      }

    Widget catBuilder(DataModel model )=> Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children:  [
          
        Image(
          
          image: NetworkImage(model.image),
          height: 120,
          width: 120,
          fit: BoxFit.cover,
          
        ),
          const SizedBox(width: 10,),
          Text(model.name,
          style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold),),
          const Spacer(),
          const Icon(Icons.arrow_circle_right_outlined,
          size: 25,)
        ],
      ),
    );

}