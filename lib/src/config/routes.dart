import 'package:fustal/src/pages/Boarding_screen.dart';
import 'package:fustal/src/pages/Favourites_screen.dart';
import 'package:fustal/src/pages/Home_Screen.dart';
import 'package:fustal/src/pages/Main_screen.dart';
import 'package:fustal/src/pages/Sign_in_screen.dart';
import 'package:fustal/src/pages/Sign_up_screen.dart';
import 'package:fustal/src/pages/forgot_password_screen.dart';
import 'package:fustal/src/pages/notification_screen.dart';
import 'package:fustal/src/pages/settings_screen.dart';

const String homeroute = "/home";
const String signuproute = "/signup";
const String signinroute = "/signin";
const String mainscreenroute = "/mainscreen";
const String boardingroute = "/boarding";
const String settingsroute = "/settings";
const String favouritesroute = "/favourites";
const String forgotpasswordroute = "/forgotpassword";
const String notificationroute = "/notification";
// const String forgotpasswordroute = "/forgotpassword";

final routes = {
  // ignore: prefer_const_constructors
  settingsroute: (context) => Settingscreen(),
  signinroute: (_) => Signinscreen(),
  signuproute: (_) => Signupscreen(),
  mainscreenroute: (_) => MainScreen(),
  boardingroute: (_) => Boardingscreen(),
  settingsroute: (_) => Settingscreen(),
  favouritesroute: (_) => Favourites(),
  forgotpasswordroute: (_) => Forgetpassword(),
  homeroute: (_) => HomeScreen(),
  notificationroute: (_) => Notificationscreen(),
};
