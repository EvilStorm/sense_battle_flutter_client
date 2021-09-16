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
  const EmailValidationScreen({Key? key}) : super(key: key);

  @override
  _EmailValidationScreenState createState() => _EmailValidationScreenState();
}

class _EmailValidationScreenState extends State<EmailValidationScreen> {
  late SignInProvider signInProvider;
  bool isDispose = false;
  bool reqValidationCode = false;
  String reqValidationCodeText = '인증번호 받기';

  final int reqValidationTerm = 60 * 5;
  int validationRemainTime = 60 * 5;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      Print.e(" Firebase Auth authStateChanges??? :$event");
      if (event == null) {
        Get.off(() => SignInScreen());
      } else if (event.emailVerified == true) {
        Get.off(() => MainScreen());
      } else {}
    });

    super.initState();
  }

  void startValifyListener() async {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (signInProvider.userCredential?.user?.emailVerified == true || isDispose) {
        timer.cancel();
      }

      await signInProvider.userCredential?.user?.reload();
    });
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  void btnEnableTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      validationRemainTime = validationRemainTime - 1;

      if (isDispose) {
        timer.cancel();
      }

      setState(() {
        if (validationRemainTime <= 0) {
          timer.cancel();

          reqValidationCode = false;
          reqValidationCodeText = '인증번호 받기';
          validationRemainTime = reqValidationTerm;
        } else {
          final time = Duration(seconds: validationRemainTime);
          reqValidationCodeText = format(time);
        }
      });
    });
  }

  void reqSendValidationEmail() {
    if (!reqValidationCode) {
      setState(() {
        reqValidationCode = true;
      });
      btnEnableTimer();
      signInProvider.userCredential!.user?.sendEmailVerification();
      startValifyListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '이메일 인증후 사용 할 수 있습니다.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: Constants.sapceGap,
            ),
            Text(
              '이메일 인증번호를 수신하기까지는 시간이 걸립니다.\n5분 후 메일이 도착하지 않을 시 다시 인증번호 받기 버튼을 눌러주세요.',
              style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: Constants.sapceGap * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () => reqSendValidationEmail(), child: Text(reqValidationCodeText)),
                ElevatedButton(
                    onPressed: () {
                      signInProvider.signInOut();
                    },
                    child: Text('로그인')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
