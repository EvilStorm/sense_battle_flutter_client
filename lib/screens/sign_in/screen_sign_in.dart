import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/providers/fetch_state.dart';

import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/sign_in/widget_border_horizental.dart';
import 'package:sense_battle/screens/sign_in/widget_sign_in_with_email.dart';
import 'package:sense_battle/screens/widgets/circular_progress.dart';
import 'package:sense_battle/utils/Print.dart';

import 'thrid_party_sign_in/widget_btns_section.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInProvider signInProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signInProvider = Provider.of<SignInProvider>(context);
    
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
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap),
                  child: Column(
                    children: [
                      SizedBox(height: Constants.sapceGap*4,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SignIn',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(height: 50.0,),
                      Container(
                        height: 300.0,
                        child: SignInWithEmail()
                      ),
                      SizedBox(height: Constants.sapceGap/2,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap),
                          child: TextButton(
                            onPressed: (){
                              Get.toNamed('/joinUs');
                            },
                            child: Text(
                              '회원가입',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Constants.sapceGap*2,),
                      HorizentalBorder(),
                      SizedBox(height: Constants.sapceGap*2,),
                      ThirdPartySignInSection(height: 100,),
                      SizedBox(height: Constants.sapceGap*4,),
          
                    ],
                  ),
                ),
                Visibility(
                  visible: signInProvider.fetchState == FetchState.PROGRESS,
                  child: CircularProgress(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

