import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/auth/auth_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, state) => state.connectionState != ConnectionState.done
          ? Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/images/logo_apps.png',
                ),
              ),
            )
          : Scaffold(body: AuthPage()),
    );
  }
}
