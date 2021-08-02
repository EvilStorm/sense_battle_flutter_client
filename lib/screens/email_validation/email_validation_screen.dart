import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/main/main_screen.dart';
import 'package:sense_battle/screens/sign_in/screen_sign_in.dart';
import 'package:sense_battle/utils/Print.dart';

class EmailValidationScreen extends StatefulWidget {
  const EmailValidationScreen({ Key? key }) : super(key: key);

  @override
  _EmailValidationScreenState createState() => _EmailValidationScreenState();
}

class _EmailValidationScreenState extends State<EmailValidationScreen> {
  
  late SignInProvider signInProvider;

  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((event) { 
      Print.e(" Firebase Auth userChanges??? :$event");

    });
    FirebaseAuth.instance.idTokenChanges().listen((event) { 
      Print.e(" Firebase Auth idTokenChanges??? :$event");
      
    });


    FirebaseAuth.instance.authStateChanges().listen((event) { 
      Print.e(" Firebase Auth authStateChanges??? :$event");
      if(event == null) {
        Get.off(() => SignInScreen());
      }else if (event.emailVerified == true) {
        Get.off(() => MainScreen());
      } else {
      }
    });

    super.initState();
  }

  void startValifyListener() async {
    Timer.periodic(Duration(seconds: 1), (timer) async { 
      
      if(signInProvider.userCredential?.user?.emailVerified == true) {
        timer.cancel();
      }

      await signInProvider.userCredential?.user?.reload();

    });

  }

  @override
  Widget build(BuildContext context) {

    SignInProvider signInProvider = Provider.of<SignInProvider>(context);

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '이메일 인증후 사용 할 수 있습니다.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: Constants.sapceGap,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signInProvider.userCredential!.user?.sendEmailVerification();
                    startValifyListener();
                  }, 
                  child: Text(
                    '인증번호 받기'
                  )
                ),

                ElevatedButton(
                  onPressed: () {
                    signInProvider.signInOut();
                  }, 
                  child: Text(
                    '로그인'
                  )
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}