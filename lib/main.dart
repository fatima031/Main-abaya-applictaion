import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tqabayaapplication/screens/auth_UI/sign-up.dart';
import 'package:tqabayaapplication/screens/auth_UI/splash_screen.dart';
import 'package:tqabayaapplication/screens/auth_UI/welcomeScreen.dart';

import 'firebase_options.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Tahir Qadri Abaya App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home:  Splash_screen(),
         builder: EasyLoading.init(),
        );
        
  }
}
