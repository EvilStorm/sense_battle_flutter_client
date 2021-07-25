
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';

class SignInWithEmail extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SignInProvider signInProvider;

  SignInWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    signInProvider = Provider.of<SignInProvider>(context);

    return Column(
      children: [
        SizedBox(height: 16.0,),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '이메일',
          ),
        ),
        SizedBox(height: 16.0,),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호',
          ),
        ),
        SizedBox(height: 16.0,),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호확인',
          ),
        ),
        SizedBox(height: 16.0,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: (){
              signInProvider.signinWithEmail(emailController.text, passwordController.text);
            },             
            child: Text(
              '회원가입',
            ),
          ),
        ),

          if (signInProvider.errorMessage != null) Text('${signInProvider.errorMessage}'),
          if (signInProvider.userCredential != null) Text('가입 성공!!!'),

      ],
    );
  }
}