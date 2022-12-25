import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tico_apps/infrastructure/auth/simple_bloc_delegate.dart';
import 'package:tico_apps/theme.dart';
import 'package:tico_apps/tico.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Tico(),
    ),
  );
}
