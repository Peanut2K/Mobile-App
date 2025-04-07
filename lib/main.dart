import 'package:flutter/material.dart';
import 'pages/first_page.dart';
import 'pages/register_page.dart';
import 'pages/signIn_page.dart';
import 'pages/home_page.dart';
import 'pages/scan_page.dart';
import 'pages/point_page.dart';
import 'pages/redeem_page.dart';
import 'pages/content_page.dart';
import 'pages/setting_page.dart';

void main() {
  runApp(const WastePointApp());
}

class WastePointApp extends StatelessWidget {
  const WastePointApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WastePoint',
      initialRoute: '/first',
      routes: {
        '/first': (context) => const FirstPage(),
        '/register': (context) => const RegisterPage(),
        '/signin': (context) => const SignInPage(),
        '/main': (context) => const MainPage(),
        '/scan': (context) => const ScanPage(),
        '/point': (context) => const PointPage(),
        '/redeem': (context) => const RedeemPage(),
        '/contents': (context) => const ContentsPage(),
        '/setting': (context) => const SettingPage(),
      },
    );
  }
}
