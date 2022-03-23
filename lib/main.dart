import 'package:cab_rider/screens/login/login_screen.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:cab_rider/screens/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Regular',
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        MainPage.routeName: (_) => const MainPage(),
      },
    );
  }
}
