import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/providers/provider_signin.dart';

import 'button_circle.dart';

class ThirdPartySignInSection extends StatefulWidget {
  final double? height;
  const ThirdPartySignInSection({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  _ThirdPartySignInSectionState createState() => _ThirdPartySignInSectionState();
}

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleButton(
            callback: () {
              signInProvider.byGoogle();
            },
            child: SvgPicture.asset(
              "assets/images/google_logo.svg",
              width: 45,
              height: 45,
            ),
          ),
          CircleButton(
            callback: () {
              signInProvider.byFacebook();
            },
            backgroundColor: Color(0xFF4267B2),
            child: SvgPicture.asset(
              "assets/images/facebook_logo.svg",
              width: 45,
              height: 45,
              color: Colors.white,
            ),
          ),
          CircleButton(
            callback: () {
              signInProvider.byKakaoTalk();
            },
            backgroundColor: Color(0xFFFFE812),
            child: SvgPicture.asset(
              "assets/images/kakaotalk_logo.svg",
              width: 45,
              height: 45,
            ),
          ),
          CircleButton(
            callback: () {
              signInProvider.byApple();
            },
            backgroundColor: Color(0xFF555555),
            child: SvgPicture.asset(
              "assets/images/apple_logo.svg",
              width: 45,
              height: 45,
            ),
          ),
        ],
      ),
    );
  }
}
