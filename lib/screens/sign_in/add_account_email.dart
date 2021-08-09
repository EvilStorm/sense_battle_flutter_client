import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/constants/constants.dart';

class AddAccountWithEmail extends StatefulWidget {

  AddAccountWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  _AddAccountWithEmailState createState() => _AddAccountWithEmailState();
}

class _AddAccountWithEmailState extends State<AddAccountWithEmail> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  late SignInProvider signInProvider;
  bool _passwordVaildation = false;
  
  @override
  void initState() {
    passwordController.addListener(() { 
      bool isTrue = isPasswodVaildate();
      if(_passwordVaildation != isTrue ) {
        setState(() {
          _passwordVaildation = isTrue;
        });
      }
    });

    super.initState();
  }

  bool isPasswodVaildate() => passwordController.text.length >= 8;

  bool checkInputVaildation() {
    if (emailController.text == "" || !EmailValidator.validate(emailController.text)) {
      signInProvider.setErrorMessage('이메일을 확인해주세요.');
      return false;
    }

    if (passwordController.text == "" || !isPasswodVaildate()) {
      signInProvider.setErrorMessage('비밀번호를 확인해주세요.');
      return false;
    }

    if (passwordCheckController.text == "" 
        || passwordController.text != passwordCheckController.text) {
      signInProvider.setErrorMessage('비밀번호 확인을 확인해주세요.');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
        Visibility(
          visible: !_passwordVaildation,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, Constants.sapceGap, 0.0, 0.0,),
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.error,
                    size: 28,
                    color: Theme.of(context).errorColor,
                  ),
                  SizedBox(width: Constants.sapceGap/2,),
                  Text(
                    '8자리 이상의 비밀번호를 입력해주세요.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(flex: 1,),
        TextField(
          controller: passwordCheckController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '비밀번호 확인',
          ),
        ),
        Spacer(flex: 2,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if(!checkInputVaildation()) {
                return;
              }
              signInProvider.addAccountWithEmail(
                  emailController.text, passwordController.text);
              
              Get.back();
            },
            child: Text(
              '회원가입',
            ),
          ),
        ),
        Spacer(flex: 1,),
      ],
    );
  }
}
