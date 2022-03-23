import 'package:cab_rider/brand_colors.dart';
import 'package:cab_rider/screens/login/login_screen.dart';
import 'package:cab_rider/screens/mainpage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/taxi_button.dart';
import '../../constants.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  RegisterScreen({Key? key}) : super(key: key);

  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser(BuildContext context) async {
    try {
      final request = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (request.user != null) {
        DatabaseReference newUserRef =
            FirebaseDatabase.instance.ref().child('users/${request.user!.uid}');
        Map userMap = {
          'fullname': fullNameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
        };

        newUserRef.set(userMap);

        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.routeName, (route) => false);
      }
    } on PlatformException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void onPressed(BuildContext context) async {
    // check for connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(context, 'No internet connectivity');
      return;
    }

    if (fullNameController.text.length < 3) {
      showSnackBar(context, 'Please provide a valid fullname');
      return;
    }

    if (phoneController.text.length < 10) {
      showSnackBar(context, 'Please provide a valid phone number');
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

    registerUser(context);
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
                  alignment: Alignment.center,
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
                        keyboardType: TextInputType.text,
                        controller: fullNameController,
                        decoration: inputDecoration('Full Name'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration('Email Address'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: inputDecoration('Phone Number'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: inputDecoration('Password'),
                      ),
                      const SizedBox(height: 20),
                      TaxiButton(
                        title: 'REGISTER',
                        onPressed: () => onPressed(context),
                        color: BrandColors.colorGreen,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (route) => false);
                        },
                        child: const Text(
                          'Already have a RIDER account? Login.',
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
    ;
  }
}
