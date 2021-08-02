import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/utils/Print.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    SignInProvider signInProvider = Provider.of<SignInProvider>(context);
    Print.e("EMAIL vaildation: ${signInProvider.userCredential?.user?.emailVerified}");
    return Container(
      child: Text('Main!!!'),
    );
  }
}