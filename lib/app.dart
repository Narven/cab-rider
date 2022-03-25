import 'package:cab_rider/screens/login/login_screen.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cab Rider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Regular',
      ),
      initialRoute: MainPage.routeName,
      routes: {
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        MainPage.routeName: (_) => const MainPage(),
      },
    );
  }
}
