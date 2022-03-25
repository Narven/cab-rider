import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../brand_colors.dart';
import '../../components/taxi_button.dart';
import '../../constants.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(BuildContext context) async {
    try {
      await showLoadingMessage(context, 'Logging you in...');

      final request = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (request.user != null) {
        final userRef =
            FirebaseDatabase.instance.ref().child('users/${request.user!.uid}');
        final once = await userRef.once();

        if (once.snapshot.value != null) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        }
      }
    } on PlatformException catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.message.toString());
    }
  }

  Future<void> onPressed(BuildContext context) async {
    // check for connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(context, 'No internet connectivity');
      return;
    }

    if (!emailController.text.contains('@')) {
      showSnackBar(context, 'Please provide a valide email');
      return;
    }

    if (passwordController.text.length < 8) {
      showSnackBar(context, 'Password should be greater than 8 characters');
      return;
    }

    await loginUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Sign In as a Rider',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Brand-Bold',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration('Email Address'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: inputDecoration('Password'),
                      ),
                      const SizedBox(height: 20),
                      TaxiButton(
                        title: 'LOGIN',
                        onPressed: () => onPressed(context),
                        color: BrandColors.colorGreen,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RegisterScreen.routeName,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Dont't have an account, sign up here.",
                          style: TextStyle(color: Colors.black87),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
