import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';

class AddAccountWithEmail extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  late SignInProvider signInProvider;

  AddAccountWithEmail({
    Key? key,
  }) : super(key: key);

  void checkInputVaildation() {
    if (emailController.text == null || EmailValidator.validate(emailController.text)) {
      signInProvider.setErrorMessage('이메일을 확인해주세요.');
      return;
    }

    if (passwordController.text == null) {
      signInProvider.setErrorMessage('비밀번호를 확인해주세요.');
      return;
    }
    
    

  }

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: 16.0,
        ),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '이메일',
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호',
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        TextField(
          controller: passwordCheckController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호확인',
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              signInProvider.signinWithEmail(
                  emailController.text, passwordController.text);
            },
            child: Text(
              '회원가입',
            ),
          ),
        ),
      ],
    );
  }
}
