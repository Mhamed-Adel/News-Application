import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app_model/search.dart';
import 'package:untitled/modules/search/cubit.dart';
import 'package:untitled/modules/search/states.dart';
import 'package:untitled/shared/component/component.dart';


class SearchScreen extends StatelessWidget {
final searchCotroller = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {
          
        },
        builder:(context, state) {
        var cubit = SearchCubit.get(context);
        return  Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  defaultFormFeild(
                    controller: searchCotroller, 
                    type: TextInputType.text, 
                    label: 'Search', 
                    prefix: Icons.search,
                    onSubmitted: (String? text){
                      cubit.getSearchData(text!);
                    }
                    ),
                    if(state is SearchSuccessState)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildSearchItems(cubit.model!.data.data[index]), 
                      separatorBuilder:(context, index) =>  myDivider(), 
                      itemCount: cubit.model!.data.data.length)
                    
                ],
              ),
            ),
          ),
        );
      
        },   ),
    );
  
  }
    Widget buildSearchItems(Data model)=> Row(
    children: [
    Image.network('${model.image}',
    width: 100,
    height: 100,),
    const SizedBox(width: 10,),
    SizedBox(
      width: 230,
      child: Column(
        
        children: [
          Text('${model.name}',
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
          ),
          const SizedBox(height: 10,),
          Text('${model.price}')
        ],
      ),
    )
    
    ],
    ) ;
}