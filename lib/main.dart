import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fustal/src/pages/Boarding_screen.dart';
import 'package:fustal/src/pages/Main_screen.dart';
import 'package:fustal/src/providers/auth_provider.dart';
import 'package:fustal/src/providers/theme_provider.dart';
import 'package:fustal/src/themes/Themes.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Themeprovider()),
    ChangeNotifierProvider(create: (_) => Authprovider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fustal',
      theme:
          Provider.of<Themeprovider>(context).darktheme ? darkmode : lightmode,
      home:  Boardingscreen(),
    );
  }
}
