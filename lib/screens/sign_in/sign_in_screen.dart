import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/sign_in/sign_in_with_email.dart';
import 'package:sense_battle/utils/Print.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInProvider signInProvider;

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);
    
    Print.e("signInProvider.errorMessage : ${signInProvider.errorMessage }", );

    if (signInProvider.errorMessage != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.snackbar(
          'what?', 
          signInProvider.errorMessage!, 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(context).errorColor,
          colorText: Colors.white
        );
        signInProvider.setErrorMessage(null);

        }
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [

              SignInWithEmail(),
            ],
          ),
        ),
      ),
    );
  }
}
