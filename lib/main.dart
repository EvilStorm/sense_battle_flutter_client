import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/constants/color_store.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/screens/email_validation/email_validation_screen.dart';
import 'package:sense_battle/screens/main/main_screen.dart';
import 'package:sense_battle/screens/sign_in/screen_join_us.dart';
import 'package:sense_battle/screens/sign_in/screen_sign_in.dart';
import 'package:sense_battle/screens/splash/screen_splash.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  } 
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  static ThemeData darkTheme = new ThemeData(     
    backgroundColor: const Color(0xFF242326),
    dialogBackgroundColor: const Color(0xFF383838),
    primaryColor: ColorStore.Dark_Primary,
    accentColor: const Color(0xFFF2A07B),
    hintColor: const Color(0xFFA49696),
    disabledColor: const Color(0xFF39311D),
    secondaryHeaderColor: const Color(0xFF31112C),
    errorColor: const Color(0xFF7D0633),
    splashColor: ColorStore.Dark_Primary,
    highlightColor: ColorStore.Dark_Primary,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorStore.Dark_Primary,
        )
      ),
      labelStyle: TextStyle(
        color:ColorStore.Dark_Primary
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          color: const Color(0xFF31112C),
          fontSize: 22.0, 
          fontWeight: FontWeight.w700,
        ),
        onPrimary: Colors.black87,
        primary: ColorStore.Dark_Primary,
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: ColorStore.Dark_Primary,
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        side: BorderSide(
          color: ColorStore.Dark_Primary,
          width: 1
        )
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: ColorStore.Dark_Primary,
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
      )
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: ColorStore.Dark_Primary),
      headline2: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: ColorStore.Dark_Primary),
      headline3: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: ColorStore.Dark_Primary),
      headline4: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      headline5: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 18.0,  ),
      bodyText2: TextStyle(fontSize: 16.0, ),
      caption: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
      button: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: const Color(0xFF31112C)),
      overline: TextStyle(fontSize: 14.0),
    ).apply(
      bodyColor: const Color(0xFFD8D8D8),
    )
    
  );
  ThemeData usedTheme = darkTheme;

  var routerPages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/signin', page: () => SignInScreen()),
    GetPage(name: '/joinUs', page: () => JoinUsScreen()),
    GetPage(name: '/emailVaildation', page: () => EmailValidationScreen()),
    GetPage(name: '/main', page: () => MainScreen()),
  ];


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SignInProvider()),
            ],
            child: GetMaterialApp(
              title: 'Sense Battle',
              debugShowCheckedModeBanner: false,
              theme: usedTheme,
              home: SplashScreen(),
              getPages: routerPages,
            ),
          );
        }

        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            "Wait a min...."
          )
        );
      },
    );
  }
}
