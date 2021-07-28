import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sense_battle/models/password_level_model.dart';
import 'package:sense_battle/utils/Print.dart';

class SignInProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _errMsg;
  PasswordLevelModel _passwordVaildationMessage = PasswordLevelModel();
  UserCredential? _userCredential;

  String? get errorMessage => _errMsg;
  PasswordLevelModel get passwordVaildationMessage =>
      _passwordVaildationMessage;
  UserCredential? get userCredential => _userCredential;

  void setErrorMessage(String? message) {
    this._errMsg = message;
    notifyListeners();
  }

  void signinWithEmail(String email, String password) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Print.i(_userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Print.i('password too weak');
        _errMsg = "비밀번호가 너무 쉽습니다.";
      } else if (e.code == 'email-aleady-in-use') {
        Print.i('The account already exists for that email.');
        _errMsg = "사용중인 이메일 입니다.";
      }
    } catch (e) {
      Print.e(e);
      _errMsg = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
