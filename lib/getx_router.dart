import 'package:get/get.dart';
import 'package:sense_battle/screens/email_validation/email_validation_screen.dart';
import 'package:sense_battle/screens/main/main_screen.dart';
import 'package:sense_battle/screens/sign_in/screen_join_us.dart';
import 'package:sense_battle/screens/sign_in/screen_sign_in.dart';
import 'package:sense_battle/screens/splash/screen_splash.dart';

class GetXRouterContainer {

  final allPageRouter = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/signin', page: () => SignInScreen()),
    GetPage(name: '/joinUs', page: () => JoinUsScreen()),
    GetPage(name: '/emailVaildation', page: () => EmailValidationScreen()),
    GetPage(name: '/main', page: () => MainScreen()),
  ];
}