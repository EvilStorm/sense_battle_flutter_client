import 'package:flutter/foundation.dart';
import 'package:sense_battle/models/model_make_sentence.dart';
import 'package:sense_battle/models/model_response.dart';
import 'package:sense_battle/network/ApiHelper.dart';
import 'package:sense_battle/utils/Print.dart';

class MakeSentenceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MakeSentenceModel? _subject;

  MakeSentenceModel? get currentSubject => _subject;

  MakeSentenceProvider() {
    reqCurrentMS();
  }

  void reqCurrentMS() async {
    try {
      ResponseModel response = await ApiHelper.instance.get('writingSubject/lastSubject');

      if (response.code < 300) {
        _subject = MakeSentenceModel.fromMap(response.data);

        Print.e(_subject);
      }

      notifyListeners();
    } catch (e) {
      Print.e(e);
    }
  }
}
