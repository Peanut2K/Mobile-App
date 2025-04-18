// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/first_page.dart';
import 'pages/register_page.dart';
import 'pages/signIn_page.dart';
import 'pages/home_page.dart';
import 'pages/scan_page.dart';
import 'pages/point_page.dart';
import 'pages/redeem_page.dart';
import 'pages/content_page.dart';
import 'pages/setting_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WastePointApp());
}

class WastePointApp extends StatelessWidget {
  const WastePointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WastePoint',
      initialRoute: '/first',

      routes: {
        '/first':    (_) => const FirstPage(),
        '/register': (_) => const RegisterPage(),
        '/signin':   (_) => const SignInPage(),
      },

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/main':
            final userId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => MainPage(userId: userId),
            );

          case '/scan':
          final userId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => ScanPage(userId: userId),
            );

          case '/point':
            final userId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => PointPage(userId: userId),
            );

          case '/redeem':
            final userId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => RedeemPage(userId: userId),
            );

          case '/contents':
            return MaterialPageRoute(
              builder: (_) => ContentsPage(),
            );

          case '/setting':
            final userId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => SettingPage(userId: userId),
            );

          default:
            return null;
        }
      },
    );
  }
}
