import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sense_battle/screens/main/main_screen.dart';
import 'package:sense_battle/screens/sign_in/screen_sign_in.dart';
import 'package:sense_battle/utils/Print.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    
    FirebaseAuth.instance.authStateChanges().listen((event) { 
      if(event == null) {
        Get.off(() => SignInScreen());
      } else {
        Get.off(() => MainScreen());
      }
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Text(
              'Sense Battle',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}