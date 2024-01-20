import 'package:flutter/material.dart';
import 'package:untitled/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
            bottomNavigationBarTheme:    const BottomNavigationBarThemeData(
              selectedItemColor: Colors.deepOrange,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromARGB(113, 96, 125, 139),
              unselectedItemColor: Colors.grey
            ),
            scaffoldBackgroundColor:  const Color.fromARGB(113, 96, 125, 139),
            primarySwatch:defaultColor ,
            appBarTheme:  const AppBarTheme(
              elevation: 0.0,
              actionsIconTheme: IconThemeData(
                color: Colors.white
              ),
              backgroundColor: Color.fromARGB(113, 96, 125, 139),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600),),
          textTheme:  const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white70
            )
          ),
          fontFamily: 'Jannah',
          
          );

ThemeData lightTheme = ThemeData(
            primarySwatch:defaultColor ,
            scaffoldBackgroundColor:Colors.white ,
            appBarTheme:  const AppBarTheme(
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: defaultColor
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.black
              ),
              
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              )
              
            ),
            bottomNavigationBarTheme:   const BottomNavigationBarThemeData(
              selectedItemColor: defaultColor,
              type: BottomNavigationBarType.fixed
            ),
            textTheme:   const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          ),
          fontFamily: 'Jannah',
          );
