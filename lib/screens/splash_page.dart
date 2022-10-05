import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/screens/google_login.dart';
import 'package:google_signin/screens/home_screen.dart';
import 'package:google_signin/utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    var auth = FirebaseAuth.instance;
    // ignore: deprecated_member_use
    auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const GoogleLoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iconLight,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/splashlogo.png')),
      ),
    );
  }
}
