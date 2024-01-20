import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state) {  },
      builder: ( context,  state) {
        var list = NewsCubit.get(context).search;
      return  Scaffold(
        appBar: AppBar(
            ),
          body:
          Column(
            children: 
                    [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: defaultFormFeild (
                controller: searchController,
                label: 'Search',
                prefix: Icons.search,
                type: TextInputType.text,
                validate: (String? value){
                  if (value!.isEmpty) {
                    print('Seach mustnot be empty');
                  } else {
                    return null;
                  }
                  return null;},
                  onChanged: (value){
                  NewsCubit.get(context).getSearch(value);
                  },
                  onSubmitted: (value){
                    NewsCubit.get(context).getSearch(value);
                  }
                  
                  ),
              ),
              Expanded(child: articleBuilder(list))
                  ],
          ),
      );
        },
        );
  }
}