import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/utils/Print.dart';

class SignInWithEmail extends StatefulWidget {
  SignInWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late SignInProvider signInProvider;

 bool isPasswodVaildate() => passwordController.text.length >= 8;

  bool checkInputVaildation() {
    if (!isCanUseEmail()) {
      signInProvider.setErrorMessage('이메일을 확인해주세요.');
      return false;
    }
    return true;
  }

  bool isCanUseEmail() {
    if (emailController.text == "" || !EmailValidator.validate(emailController.text)) {
      return false;
    }
    return true;
  }

  void passwordReset() {
    if (!isCanUseEmail()) {
      signInProvider.setErrorMessage('이메일을 입력해주세요.');
      return;
    }
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    Get.rawSnackbar(
          message: '비밀번호 초기화 링크가 이메일로 전송되었습니다.\n이메일을 확인해주세요.', 
          snackPosition: SnackPosition.TOP,
          borderRadius: Constants.sapceGap,
          duration: Duration(seconds: 2),
        );
  }

  @override
  Widget build(BuildContext context) {
emailController.text = 'gevilstorm@gmail.com';
passwordController.text = '11111111';

    Print.e("SignInWithEmail Build");
    signInProvider = Provider.of<SignInProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(flex: 1,),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '이메일',
          ),
        ),
        Spacer(flex: 1,),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호',
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => passwordReset(),
            child: Text(
              '비밀번호 초기화',
              style: Theme.of(context).textTheme.bodyText2?.apply(color: Theme.of(context).accentColor),
            ),
          ),
        ),
        Spacer(flex: 2,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if(checkInputVaildation()) {
                signInProvider.signinWithEmail(emailController.text, passwordController.text);
              }
            },
            child: Text(
              '로그인',
            ),
          ),
        ),
        Spacer(flex: 1,),
      ],
    );
  }
}
