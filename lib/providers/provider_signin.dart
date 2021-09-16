import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:sense_battle/models/model_user_info.dart';
import 'package:sense_battle/models/password_level_model.dart';
import 'package:sense_battle/network/ApiHelper.dart';
import 'package:sense_battle/network/AppException.dart';
import 'package:sense_battle/providers/fetch_state.dart';
import 'package:sense_battle/utils/Print.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum SignInType { InApp, Google, FaceBook, Kakao, Apple }

class SignInProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _errMsg;
  PasswordLevelModel _passwordVaildationMessage = PasswordLevelModel();
  UserCredential? _userCredential;
  UserInfoModel? _userInfo;

  String? get errorMessage => _errMsg;
  PasswordLevelModel get passwordVaildationMessage => _passwordVaildationMessage;
  UserCredential? get userCredential => _userCredential;
  UserInfoModel? get userInfo => _userInfo;

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
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.InApp);

      Print.i("signinWithEmail: ${_userCredential.toString()}");
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
      _userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.InApp);

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

  void byGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        _userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.Google);
      }
    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void byFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

      _userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.FaceBook);
    } catch (e) {
      Print.e(e);
      // _errMsg = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void byKakaoTalk() async {
    try {
      String authCode = await AuthCodeClient.instance.request();

      AccessTokenResponse token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token); // S

      var response = await http.post(Uri.parse("http://127.0.0.1:2394/api/auth/callbacks/kakao/token"), body: {"accessToken": token.accessToken});

      _userCredential = await FirebaseAuth.instance.signInWithCustomToken(response.body);
      _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.Kakao);

      Print.e("Token :$_userCredential");
    } catch (e) {
      Print.e(e);
    } finally {
      notifyListeners();
    }
  }

  void byApple() async {
    try {
      // final clientState = Uuid().v4();
      // final url = Uri.https('appleid.apple.com', '/auth/authorize', {
      //   'response_type': 'code id_token',
      //   'client_id': "com.hj.senseBattle",
      //   'response_mode': 'form_post',
      //   'redirect_uri':
      //       'https://irradiated-airy-citron.glitch.me/callbacks/apple/sign_in',
      //   'scope': 'email name',
      //   'state': clientState,
      // });

      // final result = await FlutterWebAuth.authenticate(
      //     url: url.toString(), callbackUrlScheme: "applink");

      // final body = Uri.parse(result).queryParameters;
      // final oauthCredential = OAuthProvider("apple.com").credential(
      //   idToken: body['id_token'],
      //   accessToken: body['code'],
      // );
      // var userCreate = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      // Print.e("Token :$userCreate");
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );

      final oAuthCredential =
          OAuthProvider("apple.com").credential(idToken: appleCredential.identityToken, accessToken: appleCredential.authorizationCode);

      _userCredential = await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
      _userInfo = await getUserInfo(_userCredential?.user?.uid, _userCredential?.user?.email, SignInType.Apple);
    } catch (e) {
      Print.e(e);
    } finally {
      notifyListeners();
    }
  }

  Future<UserInfoModel> getUserInfo(String? uId, String? email, SignInType signInType) async {
    if (uId == null) throw UnauthorisedException('회원정보가 부족하여 가입이 취소되었습니다.');

    var bodyParam = {'identifyId': uId, 'joinType': signInType.index.toString()};

    if (email != null) {
      bodyParam['email'] = email;
    }

    final response = await ApiHelper.instance.post('user', body: bodyParam);

    return UserInfoModel.fromMap(response['data']);
  }

  void signInOut() async {
    await FirebaseAuth.instance.signOut();
    _userCredential = null;
    notifyListeners();
  }
}
