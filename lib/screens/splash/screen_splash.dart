import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:sense_battle/screens/email_validation/email_validation_screen.dart';
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

    KakaoContext.clientId = "490012993a5dd6ab20a19577f3410775";

    super.initState();
    switchPage();
  }

  void switchPage() async {
    await FirebaseAuth.instance.signOut();

    FirebaseAuth.instance.authStateChanges().listen((event) { 
      if(event == null) {
        Get.off(() => SignInScreen());
      }else if (
        event.emailVerified == false 
        && event.providerData.elementAt(0).providerId == "password"
      ) {
        Get.off(() => EmailValidationScreen());
      } else {
        Get.off(() => MainScreen());
      }
    });
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