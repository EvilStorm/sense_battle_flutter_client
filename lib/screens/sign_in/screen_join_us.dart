import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/common/title_with_back.dart';
import 'package:sense_battle/screens/sign_in/widget_add_account_email.dart';
import 'package:sense_battle/screens/sign_in/widget_border_horizental.dart';
import 'package:sense_battle/utils/Print.dart';

import 'thrid_party_sign_in/widget_btns_section.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({ Key? key }) : super(key: key);

  @override
  _JoinUsScreenState createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  @override
  Widget build(BuildContext context) {

    SignInProvider signInProvider = Provider.of<SignInProvider>(context);
    
    Print.e("_userCredential: ${signInProvider.userCredential}");

    Print.w(" MediaQuery.of(context).viewInsets.bottom: ${MediaQuery.of(context).viewInsets.bottom}" );
    if (signInProvider.errorMessage != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.rawSnackbar(
          message: signInProvider.errorMessage!, 
          snackPosition: SnackPosition.TOP,
          backgroundColor: Theme.of(context).errorColor,
          borderRadius: Constants.sapceGap,
          duration: Duration(seconds: 2),
        );
        signInProvider.setErrorMessage(null);
        }
      );
    }

    if(signInProvider.userCredential != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (
          signInProvider.userCredential!.user?.emailVerified == false 
          && signInProvider.userCredential?.additionalUserInfo?.providerId == "password"
        ) {
          Get.offAllNamed('/emailVaildation');
        } else {
          Get.offAllNamed('/main');
        }
      });
    }


    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              TitleWithBack(
                title: '회원가입',
                callback: () => Get.back(),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap),
                    child: Column(
                      children: [
                        SizedBox(height: Constants.sapceGap*2,),
                        Container(
                          height: 350,
                          child: AddAccountWithEmail()
                        ),
                        SizedBox(height: Constants.sapceGap*2,),
                        HorizentalBorder(),
                        SizedBox(height: Constants.sapceGap*2,),
                        ThirdPartySignInSection(height: 100,),
                        SizedBox(height: Constants.sapceGap*4,),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
