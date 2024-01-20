// POST
// UPDATE
// DELETE

// GET https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a68f63dc1d72493ba1d0807ae505ef48

// https://gnews.io/api/v4/top-headlines?country=eg&category=world&apikey=5d8f552267aef569544db05e9fa9f74b

//https://newsdata.io/api/1/news?country=eg&category=sports&apikey=pub_20098a011a98b295090c158369b861a167b3f

import 'package:untitled/modules/shop_app/login/shop_loogin_screen.dart';
import 'package:untitled/shared/component/component.dart';
import 'package:untitled/shared/network/local/shared_helper.dart';

String? token;

void sigOut(context) {
  CachHelper.removeData(key: 'token').then((value) {
    if(value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}



