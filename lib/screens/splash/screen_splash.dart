import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/constants.dart';
import 'package:sense_battle/models/model_app_version.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/providers/provider_splash.dart';
import 'package:sense_battle/screens/splash/widget/widget_notify.dart';
import 'package:sense_battle/screens/splash/widget/widget_term.dart';
import 'package:sense_battle/screens/widgets/dialog_box.dart';
import 'package:sense_battle/utils/Print.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider provider;

  @override
  void initState() {
    KakaoContext.clientId = "490012993a5dd6ab20a19577f3410775";

    super.initState();
    switchPage();
  }

  void switchPage() async {
    // await FirebaseAuth.instance.signOut();

    // FirebaseAuth.instance.authStateChanges().listen((event) {
    //   if(event == null) {
    //     Get.off(() => SignInScreen());
    //   }else if (
    //     event.emailVerified == false
    //     && event.providerData.elementAt(0).providerId == "password"
    //   ) {
    //     Get.off(() => EmailValidationScreen());
    //   } else {
    //     Get.off(() => MainScreen());
    //   }
    // });
  }

  void checkAppVersion(AppVersionModel info) {
    if (info.nessesary) {
      DialogBox().confirmDialog(info.message, title: '필수 업데이트', leftText: '종료', rightText: '스토어 이동', barrierDismissible: false, callback: (pos) {
        Navigator.of(Get.overlayContext!).pop();
        if (pos == 0) {
          Print.e('종료');
          exit(0);
        } else {
          Print.e('스토어 이동');
        }
      });
    } else {
      DialogBox().confirmDialog(info.message, title: '업데이트', leftText: '무시', rightText: '스토어 이동', callback: (pos) {
        Navigator.of(Get.overlayContext!).pop();
        if (pos == 0) {
          Print.e('무시');
          provider.checkAppVer();
        } else {
          Print.e('스토어 이동');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SplashProvider>(context);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (provider.appVersion != null) {
        checkAppVersion(provider.appVersion!);
      }
    });

    if(provider.readyToStart) {
      var signInProvider = Provider.of<SignInProvider>(context);
      signInProvider.autoSignIn();
    }


    Print.e('Splash Build... Provider NotifyS: ${provider.notifies?.normalNotifies?.length}');
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Center(
                child: Text(
                  'Sense Battle',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              if ((provider.notifies?.normalNotifies?.length ?? 0) > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 2, vertical: Constants.sapceGap),
                  child: NotifyWidget(
                    data: provider.notifies!.normalNotifies!,
                    callback: (_) => provider.checkNotify(),
                  ),
                ),
              if (provider.term != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 2, vertical: Constants.sapceGap),
                  child: TermWidget(
                    data: provider.term!,
                    callback: (_) {
                      if (_ == -1) {
                        exit(0);
                      } else {
                        provider.checkTerm();
                      }
                    },
                  ),
                ),
            ],
            
          ),
        ),
      ),
    );
  }
}
