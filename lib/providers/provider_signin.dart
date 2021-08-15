import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:sense_battle/models/password_level_model.dart';
import 'package:sense_battle/providers/fetch_state.dart';
import 'package:sense_battle/utils/Print.dart';


class SignInProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _errMsg;
  PasswordLevelModel _passwordVaildationMessage = PasswordLevelModel();
  UserCredential? _userCredential;



  String? get errorMessage => _errMsg;
  PasswordLevelModel get passwordVaildationMessage => _passwordVaildationMessage;
  UserCredential? get userCredential => _userCredential;

  FetchState _fetchState = FetchState.IDEL;
  FetchState get fetchState => _fetchState;

  void setErrorMessage(String? message) {
    this._errMsg = message;
    notifyListeners();
  }

  void signinWithEmail(String email, String password) async {
    _fetchState = FetchState.PROGRESS;
    notifyListeners();
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Print.i("signinWithEmail: ${_userCredential.toString()}" );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Print.i('사용자가 없습니다.');
        _errMsg = "가입된 이메일이 아닙니다.";
      } else if (e.code == 'wrong-password') {
        Print.i('비밀번호가 틀렸습니다.');
        _errMsg = "비밀번호가 틀렸습니다.";
      } else {
        Print.i('What?? ${e.code}');
        _errMsg = "로그인에 실패했습니다.";
      }
    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    } finally {
      _fetchState = FetchState.IDEL;
      notifyListeners();
    }
  }
  void addAccountWithEmail(String email, String password) async {
    _fetchState = FetchState.PROGRESS;
    notifyListeners();
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Print.i(_userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Print.i('password too weak');
        _errMsg = "비밀번호가 너무 쉽습니다.";
        
      } else if (e.code == 'email-already-in-use') {
        Print.i('The account already exists for that email.');
        _errMsg = "사용중인 이메일 입니다.";
      } else {
        Print.i('What?? ${e.code}');
        _errMsg = "회원가입에 실패했습니다.";
      }

    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    } finally {
      _fetchState = FetchState.IDEL;
      notifyListeners();
    }
  }

  void getUserInfo() async {
    

  }
  void byGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

      if( googleAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );

        _userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    }finally {
      notifyListeners();
    }
  }

  void byFacebook() async {
    try {
      
      final LoginResult result = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

      _userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    }finally {
      notifyListeners();
    }
  }

  void byKakaoTalk() async {
    try {

      final installed = await isKakaoTalkInstalled();
      installed ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();

      // String authCode = await AuthCodeClient.instance.request();

      // AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
      // AccessTokenStore.instance.toStore(token); // S
      OAuthToken token = await AccessTokenStore.instance.fromStore();

      Print.e("Token :$token");
    } catch (e) {
      Print.e(e);
    }
    
  }
  
  void signInOut() async {
    await FirebaseAuth.instance.signOut();
    _userCredential = null;
    notifyListeners();
  }
}
