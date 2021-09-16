import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:sense_battle/constants/key_store.dart';
import 'package:sense_battle/models/model_app_start.dart';
import 'package:sense_battle/models/model_app_start_notify.dart';
import 'package:sense_battle/models/model_app_version.dart';
import 'package:sense_battle/models/model_response.dart';
import 'package:sense_battle/models/model_term.dart';
import 'package:sense_battle/network/ApiHelper.dart';
import 'package:sense_battle/utils/Print.dart';

class SplashProvider with ChangeNotifier, DiagnosticableTreeMixin {
  AppStartNotifyModel? notifies;
  TermModel? term;
  AppVersionModel? appVersion;

  List<bool> readyForStartFlag = [false, false, false];

  bool readyToStart = false;
  var storage = GetStorage();

  SplashProvider() {
    getAppStartData();
  }

  void getAppStartData() async {
    Print.e('getAppStartData Called');

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    int appVer = storage.read(KeyStore.appVer_I) ?? int.parse(packageInfo.buildNumber);
    int notifySeq = storage.read(KeyStore.notifySeq_I) ?? 0;
    int termSeq = storage.read(KeyStore.termSeq_I) ?? 0;

    try {
      ResponseModel response = await ApiHelper().get('appStart/notify/$notifySeq/appVer/$appVer/term/$termSeq');

      AppStartMergedDataModel model = AppStartMergedDataModel.fromMap(response.data);

      readyForStart(model);
    } catch (e) {
      Print.e(e);
    }
  }

  void readyForStart(AppStartMergedDataModel model) {
    if (model.notifies?.normalNotifies == null || (model.notifies?.normalNotifies?.isEmpty) == true) {
      readyForStartFlag[0] = true;
    } else {
      notifies = model.notifies;
    }
    if ((model.appVer?.isEmpty) == true) {
      readyForStartFlag[1] = true;
    } else {
      appVersion = model.appVer!.elementAt(0);
    }
    if (model.term == null) {
      readyForStartFlag[2] = true;
    } else {
      term = model.term;
    }

    if (!readyForStartFlag.contains(false)) {
      moveNext();
      return;
    }

    notifyListeners();
  }

  void checkNotify() {
    storage.write(KeyStore.notifySeq_I, notifies!.normalNotifies![0].id);
    readyForStartFlag[0] = true;
    notifies = null;
    moveNext();
  }

  void checkAppVer() {
    storage.write(KeyStore.appVer_I, appVersion!.version);
    readyForStartFlag[1] = true;
    appVersion = null;
    moveNext();
  }

  void checkTerm() {
    storage.write(KeyStore.termSeq_I, term!.id);
    readyForStartFlag[2] = true;
    term = null;
    moveNext();
  }

  void moveNext() {
    if (!readyForStartFlag.contains(false)) {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event == null) {
          Get.offAndToNamed('/signin');
        } else if (event.emailVerified == false && event.providerData.elementAt(0).providerId == "password") {
          Get.offAndToNamed('/emailVaildation');
        } else {
          Get.offAndToNamed('/main');
        }
      });
    }

    notifyListeners();
  }
}
