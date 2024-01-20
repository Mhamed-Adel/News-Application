import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit2/states2.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_loogin_screen.dart';
import 'package:untitled/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/component/constants.dart';
import 'package:untitled/shared/network/local/shared_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/themes.dart';
import 'layout/news_app/cubit2/cubit2.dart';

void main()  async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  bool? isDark = CachHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CachHelper.getData(key: 'onBoarding');
  token = CachHelper.getData(key: 'token');
  if(onBoarding != null){
    if(token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }

  isDark ??= false;
  onBoarding ??=false;

  runApp( MyApp( 
    startWidget: widget, 
    isDark: isDark,));
}

class MyApp extends StatelessWidget {
final bool isDark;
final Widget startWidget;
const MyApp({super.key, 
  required this.isDark,
  required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()..getScience()..getSports()),
        BlocProvider(
        create: (BuildContext context) =>
          AppCubit()..changeThemeMode(fromShared: isDark)),
        //   BlocProvider(
        // create: (BuildContext context) =>
        //   ShopCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUserData()
        //   )
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: ( context, state) {  },
        builder: ( context,  state) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:ThemeMode.light, //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home:startWidget,
          
        );
      
          },
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



