import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app_model/search.dart';
import 'package:untitled/modules/search/states.dart';
import 'package:untitled/shared/component/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
SearchCubit() : super(SearchInitialState());
static SearchCubit get(context) => BlocProvider.of(context);

 SearchModel? model;

void getSearchData(
  String text
){
  emit(SearchLoadingState());

  DioHelper.postData(
    url: SEARCH,
    token: token, 
    data: {
    'text' : text
  }).then((value) {
  model = SearchModel.fromJson(value.data);
  emit(SearchSuccessState());
  }).catchError((error){
  emit(SearchErrorState(error.toString()));
  });
}
}