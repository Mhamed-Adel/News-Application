

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app_model/favirotes_model.dart';
import 'package:untitled/shared/component/component.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/styles/colors.dart';


class FavirotesScreen extends StatelessWidget {
  const FavirotesScreen({super.key});


  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ShopCubit,ShopStates>( 
      listener: (context , state) {},
      builder: (context, state) { 
        var cubit=ShopCubit.get(context);
      return ConditionalBuilder(
        condition: state is !ShopFavoritesLoadingState,
        builder:(context) => ListView.separated(
          itemBuilder: (context , index) => buildFavItems (cubit.getFavoritesModel, index,context) , 
          separatorBuilder: (context, index) => myDivider(), 
          itemCount:cubit.getFavoritesModel!.data.data.length 
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator(),),
      );
  } ); 
}
  Widget buildFavItems(FavoritesModel? model,int index,context)=> Padding(
    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                    height: 120,
                    child: Expanded(
                      child: Row(                
                      children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        
                        children: 
                          [
                          Image(image: NetworkImage(model!.data.data[index].product.image),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          ),
                          if(model.data.data[index].product.discount != 0)
                          Container(
                            color: Colors.red,
                            width: 60,
                            height: 20,
                            child: const Center(
                              child: Text('DISCOUNT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.0
                              ),),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            Text(model.data.data[index].product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              height: 1.3,
                            ),
                            
                            ),
                            Row(
                              
                              children: [
                                Text('${model.data.data[index].product.price}',
                                style: const TextStyle(
                                  color: defaultColor
                                ),),
                                const SizedBox(width: 10,),
                                if(model.data.data[index].product.discount != 0)
                                Text('${model.data.data[index].product.oldPrice}',
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  decoration: TextDecoration.lineThrough
                                ),
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ShopCubit.get(context).favirotes[model.data.data[index].product.id] ? defaultColor : Colors.grey ,
                                  child: IconButton(
                                    onPressed: (){
                                    ShopCubit.get(context).changeFavirotes(model.data.data[index].product.id);
                                    },
                                    icon: const Icon(Icons.favorite_border),
                                    iconSize: 12,
                                    color: Colors.white,
                                    ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      ],
                      
                                      ),
                    ),
    ),
  ); 

}