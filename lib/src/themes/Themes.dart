import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fustal/src/config/config.dart';

final lightmode = ThemeData(
  primaryColor: Config().appcolor,
  fontFamily: "Poppins",
  iconTheme: IconThemeData(color: Colors.grey[900]),
  scaffoldBackgroundColor: Colors.grey.shade100,
  toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.grey.shade100),
  brightness: Brightness.light,
  shadowColor: Color(0xFFFFFFFF),
  primaryColorDark: Colors.grey[800],
  primaryColorLight: Colors.white,
  secondaryHeaderColor: Colors.grey[600],
  textTheme: TextTheme(
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
      subtitle2: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 22, color: Colors.grey[900])),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.grey[900],
    ),
    actionsIconTheme: IconThemeData(color: Colors.grey[900]),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.6,
      wordSpacing: 1,
      color: Colors.grey[900],
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Config().appcolor,
    unselectedLabelColor: Colors.grey.shade500,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Config().appcolor),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    backgroundColor: Colors.white,
    selectedItemColor: Config().appcolor,
    unselectedItemColor: Colors.grey[500],
  ),
);

final darkmode = ThemeData(
    primaryColor: Config().appcolor,
    fontFamily: "Poppins",
    iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Color(0xff303030),
    primaryColorDark: Colors.grey[300],
    toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.white),
    primaryColorLight: Colors.grey[800],
    secondaryHeaderColor: Colors.grey[400],
    brightness: Brightness.dark,
    shadowColor: const Color(0xff282828),
    textTheme: const TextTheme(
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.grey[900],
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        letterSpacing: -0.6,
        wordSpacing: 1,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   selectedIconTheme: IconThemeData(color: Colors.deepPurpleAccent),
    //   unselectedIconTheme: IconThemeData(color: Colors.white),
    //   backgroundColor: Colors.grey[900],
    //   selectedItemColor: Colors.deepPurpleAccent,
    //   unselectedItemColor: Colors.grey[500],
    // ),
    tabBarTheme: TabBarTheme(
      labelColor: Config().appcolor,
      unselectedLabelColor: Colors.white,
    ));
