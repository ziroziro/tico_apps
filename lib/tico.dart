import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tico_apps/presentation/splashscreen/splashscreen.dart';
import 'package:tico_apps/theme.dart';

class Tico extends StatefulWidget {
  @override
  _TicoState createState() => _TicoState();
}

class _TicoState extends State<Tico> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          theme: theme.getTheme(),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
