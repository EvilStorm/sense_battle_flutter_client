
import 'package:flutter/material.dart';
import 'package:sense_battle/screens/sign_in/thrid_party_signin_button.dart';

class ThirdPartySignInSection extends StatelessWidget {
  final double? height;
  const ThirdPartySignInSection({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
              
            } 
          ),
          ThridPartySignInButton(
            key: UniqueKey(), 
            svgImage: "assets/images/facebook_logo.svg", 
            iconColor: Colors.white,
            backgroundColor: Color(0xFF4267B2),
            title: "Sign in with Facebook",
            callback: () {
              
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
