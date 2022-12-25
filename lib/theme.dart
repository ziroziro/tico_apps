import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';

import 'domain/shared_preference_model.dart';

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: WHITE,
      elevation: 1,
      textTheme: TextTheme(
          headline6: TextStyle(
        color: LIGHT_BLUE,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      )));
}

AppBarTheme appBarThemeDark() {
  return AppBarTheme(
      color: Color(0xFF212121),
      elevation: 1,
      textTheme: TextTheme(
          headline6: TextStyle(
        color: LIGHT_BLUE,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      )));
}

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: appBarThemeDark(),
    primaryColor: Color(0xFF212121),
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: LIGHT_BLUE,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: appBarTheme(),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: LIGHT_BLUE,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
