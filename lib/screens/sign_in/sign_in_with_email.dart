import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';

class SignInWithEmail extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SignInProvider signInProvider;
  
 bool isPasswodVaildate() => passwordController.text.length >= 8;

  SignInWithEmail({
    Key? key,
  }) : super(key: key);

  bool checkInputVaildation() {
    if (emailController.text == "" || !EmailValidator.validate(emailController.text)) {
      signInProvider.setErrorMessage('이메일을 확인해주세요.');
      return false;
    }

    if (passwordController.text == "" || !isPasswodVaildate()) {
      signInProvider.setErrorMessage('비밀번호를 확인해주세요.');
      return false;
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
        Spacer(flex: 2,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if(checkInputVaildation()) {
  
                Get.back();
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
