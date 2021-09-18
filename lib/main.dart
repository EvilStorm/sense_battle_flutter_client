import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sense_battle/getx_router.dart';
import 'package:sense_battle/providers/provider_signin.dart';
import 'package:sense_battle/providers/provider_splash.dart';
import 'package:sense_battle/theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  Provider.debugCheckInvalidValueType = null;

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  ThemeData usedTheme = Themes.darkTheme;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => SplashProvider(),
                lazy: false,
              ),
              ChangeNotifierProvider(create: (_) => SignInProvider(),),
              
            ],
            child: GetMaterialApp(
              title: 'Sense Battle',
              debugShowCheckedModeBanner: false,
              theme: usedTheme,
              getPages: GetXRouterContainer().allPageRouter,
            ),
          );
        }

        return const Directionality(textDirection: TextDirection.ltr, child: Text("Wait a min...."));
      },
    );
  }
}
