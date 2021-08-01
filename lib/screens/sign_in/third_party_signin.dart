
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/sign_in/thrid_party_signin_button.dart';
import 'package:sense_battle/utils/Print.dart';

class ThirdPartySignInSection extends StatefulWidget {
  final double? height;
  const ThirdPartySignInSection({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  _ThirdPartySignInSectionState createState() => _ThirdPartySignInSectionState();
}
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email'
  ]
);

class _ThirdPartySignInSectionState extends State<ThirdPartySignInSection> {
  
  late SignInProvider signInProvider;
  
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);
   
    return Container(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThridPartySignInButton(
            key: UniqueKey(), 
            svgImage: "assets/images/google_logo.svg",
            title: "Sign in with Google",
            backgroundColor: Colors.white,
            textColor: Color(0xFF383838),
            callback: () {
              signInProvider.byGoogle();
            } 
          ),
          ThridPartySignInButton(
            key: UniqueKey(), 
            svgImage: "assets/images/facebook_logo.svg", 
            iconColor: Colors.white,
            backgroundColor: Color(0xFF4267B2),
            title: "Sign in with Facebook",
            callback: () {
              signInProvider.byFacebook();              
            }
          ),
          ThridPartySignInButton(
            key: UniqueKey(), 
            svgImage:"assets/images/kakaotalk_logo.svg", 
            title: "Sign in with KakaoTalk",
            backgroundColor: Color(0xFFFF812),
            callback: () {
              
            } 
          ),
          ThridPartySignInButton(
            key: UniqueKey(), 
            svgImage: "assets/images/apple_logo.svg",
            title: "Sign in with Apple",
            iconColor: Colors.black,
            backgroundColor: Color(0xFF555555),
            callback: () async {
              
            } 
          ),
        ],
      ),
    );
  }
}
